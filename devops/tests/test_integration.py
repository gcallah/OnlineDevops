from django.test import TestCase, Client
from django.contrib.auth.models import User
from django.urls import reverse


class UserAuthenticationTestCase(TestCase):
    """
    This testcase contains set of integration tests for DC-3 User Auth
    """
    def setUp(self):
        self.username = 'test_runner'
        self.password = 'dumb_runner'
        self.client = Client()

        User.objects.create_user(username=self.username,
                                 email='nobody@nowhere.com',
                                 password=self.password)

    def test_restricted_content_redirects_user_to_login(self):
        response = self.client.get(reverse('participant_home'))
        self.assertRedirects(response,
                             reverse('participant_login') +
                             '?next=' +
                             reverse('participant_home'))

    def test_authenticated_user_redirects_to_index_logout_available(self):
        self.client.login(username=self.username, password=self.password)
        response = self.client.get(reverse('devops:index'))
        expected_html = str('<a href="' +
                            reverse('participant_logout') +
                            '">Log out</a>')
        self.assertInHTML(expected_html, str(response.content))

    def test_authenticed_user_can_view_restricted_content(self):
        self.client.login(username=self.username, password=self.password)
        response = self.client.get(reverse('participant_home'))
        expected_answer = "<p>Welcome, " \
                          + self.username \
                          + "! You now seeing restricted content...</p>"
        self.assertInHTML(expected_answer, str(response.content))

    def test_unregistered_user_cannot_access_restricted_content(self):
        self.client.login(username='nonexistent', password='invalid')
        response = self.client.get(reverse('participant_home'))
        self.assertRedirects(response,
                             reverse('participant_login') +
                             '?next=' +
                             reverse('participant_home'))
