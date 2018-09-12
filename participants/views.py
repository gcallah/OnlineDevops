# Create your views here.
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse


@login_required
def home(request):
    logged_in_user = request.user.__str__()
    message = "Welcome, " + logged_in_user + "! You now seeing restricted content..."
    return HttpResponse(message)

