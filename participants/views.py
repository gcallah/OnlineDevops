# Create your views here.
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse


@login_required
def home(request):
    """
    This view demonstrates how access can be restricted
    when we need user name to collect
    :param request: browser request as HttpRequest()
    :returns: welcome message with username in it as HttpResponse()
    """
    logged_in_user = request.user.__str__()
    message = "<p>Welcome, " \
              + logged_in_user \
              + "! You now seeing restricted content...</p>"
    return HttpResponse(message)
