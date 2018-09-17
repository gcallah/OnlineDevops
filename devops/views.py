from django.contrib.auth.decorators import login_required
from django.http import request, HttpRequest, Http404, HttpResponseServerError
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages

from .models import Question

site_hdr = "The DevOps Course"


def get_filenm(mod_nm):
    return mod_nm + '.html'


def get_quiz(request, mod_nm):
    questions = Question.objects.filter(module=mod_nm)
    return render(request, get_filenm(mod_nm),
                  {'header': site_hdr, 'questions': questions, 'mod_nm': mod_nm})


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


# TODO: implement login for quiz grading
# @login_required
def grade_quiz(request: HttpRequest()) -> list:
    """
    Returns list of Questions user answered as right / wrong
    :param request: request as HttpRequest()
    :return: list() of dict() containing question, right/wrong, correct answer
    """
    if request.method == 'POST':
        graded_answers = []
        user_answers = []
        form_data = request.POST
        mod_nm = form_data['submit']

        num_ques = Question.objects.filter(module=mod_nm).count()
        num_ques_correct = 0
    else:
        raise Http404

    try:
        # get only post fields containing user answers...
        for key, value in form_data.items():
            if key.startswith('_'):
                proper_id = str(key).strip('_')
                user_answers.append({proper_id: value})

    except Exception as e:
        """
        Triggers a 500 error if there aren't any user answers
        """
        return HttpResponseServerError()

    # forces user to answer all quiz questions, redirects to module page if not completed
    # TODO: keep previously selected radio buttons checked instead of clearing form
    if len(user_answers) != num_ques:
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
        processed_answer['correctAnswer'] = original_question.correct
        processed_answer['yourAnswer'] = answered_question[id_to_retrieve]

        correctanskey = "answer{}".format(processed_answer['correctAnswer'].upper())
        youranskey = "answer{}".format(processed_answer['yourAnswer'].upper()) 

        processed_answer['correctAnswerText'] = getattr(original_question, correctanskey) 
        processed_answer['yourAnswerText'] = getattr(original_question, youranskey) 

        # and now we are evaluating either as right or wrong...
        if answered_question[id_to_retrieve] == original_question.correct.lower():
            processed_answer['message'] = "Congrats, thats correct!"
            processed_answer['status'] = "right"
            num_ques_correct += 1
        else:
            processed_answer['message'] = "Sorry, that's incorrect!"
            processed_answer['status'] = "wrong"

        # and store to ship to the Template.
        graded_answers.append(processed_answer)

    # Calculating quiz score
    num_ques_correct_percentage = int((num_ques_correct / num_ques) * 100)

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

    # ok, all questions processed, lets render results...
    return render(request, 'graded_quiz.html', dict(graded_answers=graded_answers,
                                                    num_ques=num_ques,
                                                    num_ques_correct=num_ques_correct,
                                                    num_ques_correct_percentage=num_ques_correct_percentage,
                                                    quiz_name=quiz_name.get(mod_nm),
                                                    header=site_hdr))
