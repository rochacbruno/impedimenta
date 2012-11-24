'''Defines how the MHS application responds to HTTP requests.'''
# For creating http.HttpResponse objects.
from django import http
# Allows templates to be used.
from django import template
# For user authentication
from django.contrib import auth
from django.contrib.auth.decorators import login_required

def home_redirect(request):
    '''Redirects the user to their homepage.'''
    # FIXME: integrate into URLConf
    # (unused argument 'request') pylint: disable-msg=W0613
    return http.HttpResponseRedirect('./home/')

@login_required(login_url = '../login')
def home(request):
    tplate = template.loader.get_template('mhs/default.html')
    ctext = template.RequestContext(
        request,
        {
            'title': 'home',
            'body': 'Current user: {}'.format(request.user),
            'home_url': '../home/',
            'logout_url': '../logout',
        }
    )
    return http.HttpResponse(tplate.render(ctext))

def login(request):
    '''Prompts user to log in and processes log in requests.

    By default, this view prompts the user to enter their credentials into a
    form. When the user submits the form, this view ensures that the form was
    filled out correctly, the user's credentials are correct, and the user's
    account is active. If all of those conditions are correct, the user is
    forwarded to their homepage. Otherwise, the user is sent back to the login
    page and a descriptive error message is displayed.

    '''
    # Give the user a login form.
    if "POST" != request.method:
        tplate = template.loader.get_template('mhs/login.html')
        ctext = template.RequestContext(
            request,
            {'login_form_url': '../login/'}
        )
        return http.HttpResponse(tplate.render(ctext))

    # Are the credentials indicated on the form valid?
    username = request.POST.get('username', '')
    password = request.POST.get('password', '')
    user = auth.authenticate(username = username, password = password)
    if user is None:
        tplate = template.loader.get_template('mhs/login.html')
        ctext = template.RequestContext(
            request,
            {
                'login_form_url': '../login/',
                'err_msg': 'Error: Your username and password were incorrect.'
            }
        )
        return http.HttpResponse(tplate.render(ctext))

    # Is the user's account active?
    if not user.is_active:
        tplate = template.loader.get_template('mhs/login.html')
        ctext = template.RequestContext(
            request,
            {
                'login_form_url': '../login/',
                'err_msg': 'Error: Your account has been disabled.'
            }
        )
        return http.HttpResponse(tplate.render(ctext))

    # Form was filled out, credentials are OK, and user is active.
    auth.login(request, user)
    return http.HttpResponseRedirect('../home/')

def logout(request):
    '''Logs out the current user and redirects them to the login page.'''
    auth.logout(request)
    return http.HttpResponseRedirect('../login/')
