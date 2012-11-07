'''Defines how the MHS application responds to HTTP requests.'''
# For creating http.HttpResponse objects.
from django import http
# Allows templates to be used.
from django import template
# For user authentication
from django.contrib import auth

def home_redirect(request):
    '''Redirects the user to their homepage.'''
    # (unused argument 'request') pylint: disable-msg=W0613
    return http.HttpResponseRedirect('./home')

def home(request):
    if not request.user.is_authenticated():
        return http.HttpResponseRedirect('../login/')

    tplate = template.loader.get_template('mhs/default.html')
    message = 'Your current user is: {}'.format(request.user)
    ctext = template.RequestContext(
        request,
        {
            'title': 'home',
            'body': message,
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
        ctext = template.RequestContext(request, {'dest_url': '../login/'})
        return http.HttpResponse(tplate.render(ctext))

    # User submitted the login form. Did they fill out all its fields?
    submission = request.POST.dict()
    try:
        username = submission['username']
        password = submission['password']
    except KeyError:
        tplate = template.loader.get_template('mhs/login.html')
        ctext = template.RequestContext(
            request,
            {
                'dest_url': '../login/',
                'err_msg': 'Error: Not all fields were filled out.'
            }
        )
        return http.HttpResponse(tplate.render(ctext))

    # All form fields were filled out. Are the credentials ok?
    user = auth.authenticate(username = username, password = password)
    if None == user:
        # Credentials are not ok.
        tplate = template.loader.get_template('mhs/login.html')
        ctext = template.RequestContext(
            request,
            {
                'dest_url': '../login/',
                'err_msg': 'Error: Your username and password were incorrect.'
            }
        )
        return http.HttpResponse(tplate.render(ctext))

    # Credentials are ok. Is the user's account active?
    if not user.is_active:
        tplate = template.loader.get_template('mhs/login.html')
        ctext = template.RequestContext(
            request,
            {
                'dest_url': '../login/',
                'err_msg': 'Error: Your account has been disabled.'
            }
        )
        return http.HttpResponse(tplate.render(ctext))

    # Yes, user account is active.
    return http.HttpResponseRedirect('../home')

def logout(request):
    '''Logs out the current user and forwards them to the login page.'''
    auth.logout(request)
    return http.HttpResponseRedirect('../login/')
