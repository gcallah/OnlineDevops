from django.contrib.auth.decorators import login_required
from django.http import request, HttpRequest, Http404, HttpResponseServerError, HttpResponseBadRequest
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from decimal import Decimal
import random

from .models import Question, Grade, Quiz

site_hdr = "The DevOps Course"


def get_filenm(mod_nm):
    return mod_nm + '.html'


def get_quiz(request, mod_nm):

    #  Returns list of Randomized Questions
    # :param: mod_nm
    # :return: header, list() containing randomized questions, mod_nm
    try:

        questions = Question.objects.filter(module=mod_nm)
        number_of_questions = questions.count()
        number_of_questions_to_randomize = int(number_of_questions * .8)
        questions_randomized = random.sample(list(questions), number_of_questions_to_randomize)

        return render(request, get_filenm(mod_nm),
                      {'header': site_hdr, 'questions': questions_randomized, 'mod_nm': mod_nm})

        # And if we crashed along the way - we crash gracefully...
    except Exception as e:
        return HttpResponseServerError(e.__cause__,
                                       e.__context__,
                                       e.__traceback__)

def index(request: request) -> object:
    return render(request, 'index.html', {'header': site_hdr})


def about(request: request) -> object:
    return render(request, 'about.html', {'header': site_hdr})


def gloss(request: request) -> object:
    return render(request, 'gloss.html', {'header': site_hdr})


def teams(request: request) -> object:
    return render(request, 'teams.html', {'header': site_hdr})


def build(request: request) -> object:
    return get_quiz(request, 'build')


def cloud(request: request) -> object:
    return get_quiz(request, 'cloud')


def comm(request: request) -> object:
    return get_quiz(request, 'comm')


def flow(request: request) -> object:
    return get_quiz(request, 'flow')


def incr(request: request) -> object:
    return get_quiz(request, 'incr')


def infra(request: request) -> object:
    return get_quiz(request, 'infra')


def micro(request: request) -> object:
    return get_quiz(request, 'micro')


def monit(request: request) -> object:
    return get_quiz(request, 'monit')


def secur(request: request) -> object:
    return get_quiz(request, 'secur')


def sum(request: request) -> object:
    return get_quiz(request, 'sum')


def test(request: request) -> object:
    return get_quiz(request, 'test')


def work(request: request) -> object:
    return get_quiz(request, 'work')


def grade_quiz(request: HttpRequest()) -> list:
    """
    Returns list of Questions user answered as right / wrong
    :param request: request as HttpRequest()
    :return: list() of dict() containing question, right/wrong, correct answer
    """
    try:
        # First, we process only when form is POSTed...
        if request.method == 'POST':
            graded_answers = []
            user_answers = []
            form_data = request.POST
            num_ques_correct = 0

            # get only post fields containing user answers...
            for key, value in form_data.items():
                if key.startswith('_'):
                    proper_id = str(key).strip('_')
                    user_answers.append({proper_id: value})

            # forces user to answer all quiz questions, redirects to module page if not completed
            # TODO: keep previously selected radio buttons checked instead of clearing form
            mod_nm = form_data['submit']
            num_ques_of_quiz = Question.objects.filter(module=mod_nm).count()

            number_of_ques_to_check = int(num_ques_of_quiz * .8) #Number of randomized questions from get_quiz.

            if len(user_answers) != number_of_ques_to_check:
                messages.warning(request, 'Please complete all questions before submitting')
                return redirect('/devops/' + mod_nm)

            # now get those answers from database & check if answer is right...
            for answered_question in user_answers:
                processed_answer = {}
                id_to_retrieve = next(iter(answered_question))
                original_question = get_object_or_404(Question, pk=id_to_retrieve)

                # Lets start building a dict with the status for this particular question...
                # Following the DRY principle - here comes shared part for both cases...
                processed_answer['question'] = original_question.text
                processed_answer['correctAnswer'] = original_question.correct.lower()
                processed_answer['yourAnswer'] = answered_question[id_to_retrieve]

                correctanskey = "answer{}".format(processed_answer['correctAnswer'].upper())
                youranskey = "answer{}".format(processed_answer['yourAnswer'].upper())

                processed_answer['correctAnswerText'] = getattr(original_question, correctanskey)
                processed_answer['yourAnswerText'] = getattr(original_question, youranskey)

                # and now we are evaluating either as right or wrong...
                if answered_question[id_to_retrieve] == processed_answer['correctAnswer']:
                    processed_answer['message'] = "Congrats, thats correct!"
                    processed_answer['status'] = "right"
                    num_ques_correct += 1
                else:
                    processed_answer['message'] = "Sorry, that's incorrect!"
                    processed_answer['status'] = "wrong"
                    # and store to ship to the Template.
                graded_answers.append(processed_answer)

            # Calculating quiz score
            num_ques_correct_percentage = Decimal((num_ques_correct / number_of_ques_to_check) * 100)

            # Pass a quiz name to view & display at Here are your quiz results
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

            # now we are ready to record quiz results...
            if request.user.username != '':
                action_status = Grade.objects.create(participant=request.user,
                                                     score=num_ques_correct_percentage.real,
                                                     quiz=Quiz.objects.get(module=mod_nm),
                                                     quiz_name=mod_nm)

            # ok, all questions processed, lets render results...
            return render(request, 'graded_quiz.html', dict(graded_answers=graded_answers,
                                                            num_ques=number_of_ques_to_check,
                                                            num_ques_correct=num_ques_correct,
                                                            num_ques_correct_percentage=int(num_ques_correct_percentage),
                                                            quiz_name=quiz_name.get(mod_nm),
                                                            header=site_hdr))


        # If it is PUT, DELETE etc. we say we dont do that...
        else:
            raise HttpResponseBadRequest("ERROR: Method not allowed")

    # And if we crashed along the way - we crash gracefully...
    except Exception as e:
        return HttpResponseServerError(e.__cause__,
                                       e.__context__,
                                       e.__traceback__)
