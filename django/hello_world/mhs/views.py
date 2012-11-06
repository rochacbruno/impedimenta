'''Defines how the MHS application responds to HTTP requests.'''
# For creating http.HttpResponse objects.
from django import http
# Allows templates to be used.
from django import template

def home(request):
    tplate = template.loader.get_template('mhs/default.html')
    message = 'You\'ve reached what will become an individualized home page. '\
        'This page should be restricted to logged-in users.'
    ctext = template.RequestContext(
        request,
        {
            'title': 'home',
            'body': message,
        }
    )
    return http.HttpResponse(tplate.render(ctext))

def login(request):
    '''Either prompts user to log in or processes log in requests.

    By default, this view simply prompts the user to enter their credentials.
    When the user submits credentials, this view validates those credentials.
    If credentials are valid, the user is forwarded to the home page. Otherwise,
    they are sent back to this page.

    '''
    # Give the user a login form.
    if("POST" != request.method):
        tplate = template.loader.get_template('mhs/login.html')
        ctext = template.RequestContext(request, {'dest_url': '../login/'})
        return http.HttpResponse(tplate.render(ctext))

    # User submitted the login form. Did they fill out all its fields?
    submission = request.POST.dict()
    if('username' in submission and 'password' in submission
        and submission['username'] and submission['password']
    ):
        # Yes, all fields filled out. Are their credentials correct?
        # TODO: must implement users before able to check credentials
        return http.HttpResponseRedirect('../')

    # Not all fields were filled out. Give them login form with error message.
    tplate = template.loader.get_template('mhs/login.html')
    ctext = template.RequestContext(
        request,
        {
            'dest_url': '../login/',
            'err_msg': 'Error: Not all fields were filled out.'
        }
    )
    return http.HttpResponse(tplate.render(ctext))
