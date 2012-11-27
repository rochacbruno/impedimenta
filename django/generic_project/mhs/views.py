'''Defines how the MHS application responds to HTTP requests.'''
# For form input validation.
from django.contrib.auth.decorators import login_required # user authentication
from django.contrib import auth # user authentication
from django import http # For creating http.HttpResponse objects
from django import template
from mhs import models

def home_redirect(request):
    '''Redirects the user to their homepage.'''
    # FIXME: integrate into URLConf
    # (unused argument 'request') pylint: disable-msg=W0613
    return http.HttpResponseRedirect('./home/')

@login_required(login_url = '../login/')
def home(request):
    '''Provides links to other sections of the MHS website.'''
    is_mhs_admin = False
    for group in request.user.groups.all():
        if "mhs-admin" == group.name:
            is_mhs_admin = True
    tplate = template.loader.get_template('mhs/home.html')
    ctext = template.RequestContext(request, {"is_mhs_admin": is_mhs_admin})
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
        ctext = template.RequestContext(request, {})
        return http.HttpResponse(tplate.render(ctext))

    # Are the credentials indicated on the form valid?
    username = request.POST.get('username', '')
    password = request.POST.get('password', '')
    user = auth.authenticate(username = username, password = password)
    if user is None:
        tplate = template.loader.get_template('mhs/login.html')
        ctext = template.RequestContext(
            request,
            {'err_msg': 'Error: Your username and password were incorrect.'}
        )
        return http.HttpResponse(tplate.render(ctext))

    # Is the user's account active?
    if not user.is_active:
        tplate = template.loader.get_template('mhs/login.html')
        ctext = template.RequestContext(
            request,
            {'err_msg': 'Error: Your account has been disabled.'}
        )
        return http.HttpResponse(tplate.render(ctext))

    # Form was filled out, credentials are OK, and user is active.
    auth.login(request, user)
    return http.HttpResponseRedirect('../home/')

def logout(request):
    '''Logs out the current user and redirects them to the login page.'''
    auth.logout(request)
    return http.HttpResponseRedirect('../login/')

@login_required(login_url = '../login/')
def find_patient(request):
    '''Find a hospital patient.'''
    tplate = template.loader.get_template('mhs/find_patient.html')
    ctext = template.RequestContext(request, {})
    return http.HttpResponse(tplate.render(ctext))

@login_required(login_url = '../login/')
def add_patient(request):
    '''Prompts user to create a new patient and processes those requests.'''
    # Give the user a login form.
    if "POST" != request.method:
        tplate = template.loader.get_template('mhs/add_patient.html')
        ctext = template.RequestContext(request, {'form': models.PatientForm()})
        return http.HttpResponse(tplate.render(ctext))

    # Are there errors in the submitted form?
    form = models.PatientForm(request.POST)
    if not form.is_valid():
        tplate = template.loader.get_template('mhs/add_patient.html')
        ctext = template.RequestContext(
            request,
            {'form': form}
        )
        return http.HttpResponse(tplate.render(ctext))

    # TODO: Form is valid. Create a new patient and redirect user to the
    # appropriate "edit patient" page.
    tplate = template.loader.get_template('mhs/add_patient.html')
    ctext = template.RequestContext(request, {'form': models.PatientForm()})
    return http.HttpResponse(tplate.render(ctext))

@login_required(login_url = '../login/')
def edit_patient(request):
    '''Edit information about a hospital patient.'''
    tplate = template.loader.get_template('mhs/edit_patient.html')
    ctext = template.RequestContext(request, {})
    return http.HttpResponse(tplate.render(ctext))

@login_required(login_url = '../login/')
def gen_report(request):
    '''Allow user to generate statistical reports about patients.'''
    is_mhs_admin = False
    for group in request.user.groups.all():
        if "mhs-admin" == group.name:
            is_mhs_admin = True
    tplate = template.loader.get_template('mhs/gen_report.html')
    ctext = template.RequestContext(request, {"is_mhs_admin": is_mhs_admin})
    return http.HttpResponse(tplate.render(ctext))

@login_required(login_url = '../login/')
def change_password(request):
    '''Allows a user to change their password.'''
    tplate = template.loader.get_template('mhs/change_password.html')
    ctext = template.RequestContext(request, {})
    return http.HttpResponse(tplate.render(ctext))

@login_required(login_url = '../login/')
def find_user(request):
    '''Find a system user.'''
    is_mhs_admin = False
    for group in request.user.groups.all():
        if "mhs-admin" == group.name:
            is_mhs_admin = True
    tplate = template.loader.get_template('mhs/find_user.html')
    ctext = template.RequestContext(request, {"is_mhs_admin": is_mhs_admin})
    return http.HttpResponse(tplate.render(ctext))

@login_required(login_url = '../login/')
def edit_user(request):
    '''Edit information about a system user.'''
    is_mhs_admin = False
    for group in request.user.groups.all():
        if "mhs-admin" == group.name:
            is_mhs_admin = True
    tplate = template.loader.get_template('mhs/edit_user.html')
    ctext = template.RequestContext(request, {"is_mhs_admin": is_mhs_admin})
    return http.HttpResponse(tplate.render(ctext))
