from unittest import skip

from autofixture import AutoFixture
from django.http import HttpResponseForbidden, HttpResponseBadRequest
from django.test import TestCase, Client
from django.contrib.auth.models import User
from django.urls import reverse
from devops.models import Quiz, Question


class GradeQuizTestCase(TestCase):
    """
    What is Test Case? A Test Case is a set of actions executed
    to verify a particular feature or functionality of your software application.
    This test tests if our grade_quiz() does what is defined in the user story.
    """

    def setUp(self):
        """
        This method is called when you need to prepare some data to run your test.
        It is executed once in the beginning of the test case.
        """
        # TODO: use Module.objects instead
        quiz_name = {
            'work': 'MOD1: The DevOps Way of Work',
            'comm': 'MOD2: Cooperation and Communication (Tool: Slack)',
            'incr': 'MOD3: Incremental Development (Tool: git)',
            'build': 'MOD4: Automating Builds (Tool: make)',
            'flow': 'MOD5: Workflow (Tool: kanban boards)',
            'test': 'MOD6: Automating Testing (Tool: Jenkins)',
            'infra': 'MOD7: Software as Infrastructure (Tool: Docker)',
            'cloud': 'MOD8: Cloud Deployment (Tool: Kubernetes)',
            'micro': 'MOD9: Microservices and Serverless Computing',
            'monit': 'MOD10: Monitoring (Tool: StatusCake)',
            'secur': 'MOD11: Security',
            'sum': 'MOD12: Summing Up',
        }

        # How many questions you want for each module?
        self.num_questions_to_test = 10

        # lets create a user...
        self.username = 'robotest'
        self.password = 'valid_password'
        self.client = Client()
        self.user = User.objects.create_user(self.username, 'fake@email.com', self.password)

        # then lets create a quiz & questions for each of the Modules...

        for key, value in quiz_name.items():
            next_quiz = Quiz.objects.create(
                module=key,
                minpass=80,
                numq=self.num_questions_to_test)

            # This is a preform to be used to generate quizz's Questions.
            # This one will allows us create any number of tasks for current Quiz
            # with the A being the right choice...
            fixture = AutoFixture(Question, generate_fk=True, field_values={
                'correct': 'a',
                'module': key
            })

            # create num_questions_to_test and store them...
            self.questions = fixture.create(self.num_questions_to_test, commit=True)


        # Read about it here: https://martinfowler.com/articles/mocksArentStubs.html#TheDifferenceBetweenMocksAndStubs

        # ok, we are all set - we have quizzes, questions, and the user. Lets rock!

    @skip
    def test_grade_quiz_sending_anything_except_POST_request_shall_be_disallowed(self):
        results = self.client.put(reverse('devops:grade_quiz'))
        self.assertRaises(HttpResponseBadRequest)

    def test_grade_quiz_displays_correct_quiz_score(self):
        """
        Integration test for DC-6 Display score to the user
        Checks if grade_quiz() calculates user score right.
        """
        # get all Quizzes...
        quizzes = Quiz.objects.all()

        # for each of the Quizzes lets try to answer it...
        for quiz in quizzes:
            # get all questions & Generate form_data with the right answers...
            quiz_questions = Question.objects.filter(module=quiz.module)

            # Now lets build a form...
            form_data = {}
            for question in quiz_questions:
                form_data['_' + str(question.pk)] = question.correct

            form_data['submit'] = quiz.module

            # Send form_data in POST request...
            results = self.client.post(reverse('devops:grade_quiz'), data=form_data)

            # get results and check if it corrects ones - right template, right messages...
            # Did the right template was used?
            self.assertTemplateUsed(results, template_name='graded_quiz.html')

            # Did all answers were graded?
            graded_answers = results.context['graded_answers']
            self.assertEqual(len(graded_answers), self.num_questions_to_test)

            # Did we counter results right?
            expected_message = "<span>You have correctly answered {0} out of {1} questions giving you a score of 100%!</span>".format(
                str(self.num_questions_to_test), str(self.num_questions_to_test))
            self.assertInHTML(expected_message, str(results.content))

    def test_grade_quiz_displays_right_wrong_answers(self):
        # get all Quizzes...
        """
        Integration test for  for DC-5 Display correct answers.
        Check is returned graded_answers done right work evaluating right & wrong.
        """
        quizzes = Quiz.objects.all()

        # for each of the Quizzes lets try to answer it...
        answers_given = {}
        for quiz in quizzes:
            # get all questions & Generate form_data with the right answers...
            quiz_questions = Question.objects.filter(module=quiz.module)

            # Now lets build a form, interleaving rights \ wrongs...
            running_id = 0
            answer_status = ''
            form_data = {}
            for question in quiz_questions:
                answer_status = ''
                if running_id % 2 == 0:
                    form_data['_' + str(question.pk)] = question.correct
                    answer_status = 'right'
                else:
                    possible_answers = ['A', 'B', 'C', 'D', 'E']
                    possible_answers.remove(question.correct.upper())
                    form_data['_' + str(question.pk)] = possible_answers.pop()
                    answer_status = 'wrong'
                # Now lets store given answer for future evaluation...
                status_record = {
                    'answer_given': form_data['_' + str(question.pk)],
                    'answer_status': answer_status
                }
                answers_given[question.text] = status_record

            # Send form_data in POST request...
            form_data['submit'] = quiz.module
            results = self.client.post(reverse('devops:grade_quiz'), data=form_data)

            # Lets get evaluation results...
            graded_answers = results.context['graded_answers']

            # Did all answers were graded?
            self.assertEqual(len(graded_answers), self.num_questions_to_test)

            # Did we got all the messages right?..
            for graded_answer in graded_answers:
                # Find this question in given answer...
                specimen = answers_given[graded_answer['question']]
                # Check what answer was given and does it match right one & assert that they match......
                self.assertEqual(specimen['answer_status'], graded_answer['status'])









