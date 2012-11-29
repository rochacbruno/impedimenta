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

def admin_redirect(request):
    '''Redirects the user to the django admin interface.'''
    # FIXME: integrate into URLConf
    # (unused argument 'request') pylint: disable-msg=W0613
    return http.HttpResponseRedirect('/admin/')

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
    # Give the user a form to fill out. Also show some patients.
    if "POST" != request.method:
        tplate = template.loader.get_template('mhs/find_patient.html')
        ctext = template.RequestContext(
            request,
            {
                'form': models.PatientSearchForm(),
                'patients': models.Patient.objects.order_by(
                    'basic_info__last_name',
                    'basic_info__first_name'
                )[0:50]
            }
        )
        return http.HttpResponse(tplate.render(ctext))

    # Are there errors in the submitted form?
    form = models.PatientSearchForm(request.POST)
    if not form.is_valid():
        tplate = template.loader.get_template('mhs/find_patient.html')
        ctext = template.RequestContext(
            request,
            {
                'form': form,
                'patients': models.Patient.objects.order_by(
                    'basic_info__last_name',
                    'basic_info__first_name'
                )[0:50]
            }
        )
        return http.HttpResponse(tplate.render(ctext))

    # Grab fields submitted by user.
    first_name = form.cleaned_data['patient_first_name']
    last_name = form.cleaned_data['patient_last_name']
    date_of_birth_start = form.cleaned_data['patient_date_of_birth_start']
    date_of_birth_end = form.cleaned_data['patient_date_of_birth_end']
    social_security_number = form.cleaned_data['patient_social_security_number']
    phone_number = form.cleaned_data['patient_phone_number']

    # Perform search
    query = models.Patient.objects
    if first_name:
        query = query.filter(basic_info__first_name__icontains = first_name)
    if last_name:
        query = query.filter(basic_info__last_name__icontains = last_name)
    if social_security_number:
        query = query.filter(social_security_number__icontains = social_security_number)
    if phone_number:
        query = query.filter(basic_info__phone_number__icontains = phone_number)

    if date_of_birth_start or date_of_birth_end:
        # If both a start and end date are given, search within that range.
        # Else if a single date is given, search for an exact match.
        if date_of_birth_start and date_of_birth_end:
            query = query.filter(date_of_birth__range = (
                date_of_birth_start,
                date_of_birth_end,
            ))
        elif date_of_birth_start:
            query = query.filter(date_of_birth = date_of_birth_start)
        else:
            query = query.filter(date_of_birth = date_of_birth_end)

    # Render results.
    tplate = template.loader.get_template('mhs/find_patient.html')
    ctext = template.RequestContext(
        request,
        {
            'form': form,
            'patients': query.order_by(
                'basic_info__last_name',
                'basic_info__first_name'
            )[0:50],
        }
    )
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

    # TODO: does person already exist? if so, immediately redirect

    # Assemble each portion of the new Patient object in turn. Each object must
    # be saved before it's ID is available.
    person = models.Person(
        first_name = form.cleaned_data['patient_first_name'],
        last_name = form.cleaned_data['patient_last_name'],
        phone_number = form.cleaned_data['patient_phone_number'],
        address = form.cleaned_data['patient_address'],
    )
    person.save()

    emergency_contact = models.Person(
        first_name = form.cleaned_data['emergency_contact_first_name'],
        last_name = form.cleaned_data['emergency_contact_last_name'],
        phone_number = form.cleaned_data['emergency_contact_phone_number'],
        address = form.cleaned_data['emergency_contact_address'],
    )
    emergency_contact.save()

    doctor = models.Person(
        first_name = form.cleaned_data['doctor_first_name'],
        last_name = form.cleaned_data['doctor_last_name'],
        phone_number = form.cleaned_data['doctor_phone_number'],
        address = form.cleaned_data['doctor_address'],
    )
    doctor.save()

    insurance = models.InsuranceProvider(
        name = form.cleaned_data['insurance_name'],
        phone_number = form.cleaned_data['insurance_phone_number'],
        address = form.cleaned_data['insurance_address'],
    )
    insurance.save()

    # (Instance of 'Person' has no 'id' member) pylint: disable-msg=E1101
    # True, neither Person nor InsuranceProvider have an 'id' member. Upon
    # calling save(), however, such a member is made available.
    patient = models.Patient(
        date_of_birth = form.cleaned_data['patient_date_of_birth'],
        place_of_birth = form.cleaned_data['patient_place_of_birth'],
        social_security_number = form.cleaned_data['patient_social_security_number'],
        health_issues = form.cleaned_data['patient_health_issues'],
        basic_info_id = person.id,
        emergency_contact_id = emergency_contact.id,
        primary_care_doctor_id = doctor.id,
        insurance_provider_id = insurance.id,
    )
    patient.save()

    request.session['add_patient_success'] = True
    return http.HttpResponseRedirect('../edit_patient_{}'.format(patient.id))

@login_required(login_url = '../login/')
def edit_patient(request, patient_id):
    '''Edit information about a hospital patient.'''
    # Give the user info about the patient they're querying. If that patient
    # does not exist, inform them of the error of their ways.
    if "POST" != request.method:
        # The django framework does magic here that's impenetrable to pylint.
        # I don't think those members are in the Patient class definition.
        # ( Class 'Patient' has no 'objects' member) pylint: disable-msg=E1101
        # ( Class 'Patient' has no 'DoesNotExist' member) pylint: disable-msg=E1101
        try:
            patient = models.Patient.objects.get(pk=patient_id)
        except models.Patient.DoesNotExist:
            tplate = template.loader.get_template('404.html')
            ctext = template.RequestContext(request, {})
            return http.HttpResponse(tplate.render(ctext))

        # Patient exists. Use their info to pre-populate the edit patient form.
        form = models.PatientForm(
            initial = {
                'patient_first_name': patient.basic_info.first_name,
                'patient_last_name': patient.basic_info.last_name,
                'patient_phone_number': patient.basic_info.phone_number,
                'patient_address': patient.basic_info.address,
                'patient_date_of_birth': patient.date_of_birth,
                'patient_place_of_birth': patient.place_of_birth,
                'patient_social_security_number': patient.social_security_number,
                'patient_health_issues': patient.health_issues,
                'doctor_first_name': patient.primary_care_doctor.first_name,
                'doctor_last_name': patient.primary_care_doctor.last_name,
                'doctor_phone_number': patient.primary_care_doctor.phone_number,
                'doctor_address': patient.primary_care_doctor.address,
                'emergency_contact_first_name': patient.emergency_contact.first_name,
                'emergency_contact_last_name': patient.emergency_contact.last_name,
                'emergency_contact_phone_number': patient.emergency_contact.phone_number,
                'emergency_contact_address': patient.emergency_contact.address,
                'insurance_name': patient.insurance_provider.name,
                'insurance_phone_number': patient.insurance_provider.phone_number,
                'insurance_address': patient.insurance_provider.address,
            }
        )

        # Did the user just finish creating or editing this patient? Or are they
        # requesting this page for the first time?
        if 'edit_patient_success' in request.session \
        and request.session['edit_patient_success']:
            message = 'Changes saved.'
            del request.session['edit_patient_success']

        if 'add_patient_success' in request.session \
        and request.session['add_patient_success']:
            message = 'Patient added.'
            del(request.session['add_patient_success'])

        # Give back the pre-populated form.
        tplate = template.loader.get_template('mhs/edit_patient.html')
        ctext = template.RequestContext(
            request,
            {
                'form': form,
                'success_message': message,
            }
        )
        return http.HttpResponse(tplate.render(ctext))

    # User is trying to make changes. Are there errors in the submitted form?
    form = models.PatientForm(request.POST)
    if not form.is_valid():
        tplate = template.loader.get_template('mhs/edit_patient.html')
        ctext = template.RequestContext(
            request,
            {'form': form}
        )
        return http.HttpResponse(tplate.render(ctext))

    # Save the requested changes.
    # ( Class 'Patient' has no 'objects' member) pylint: disable-msg=E1101
    patient = models.Patient.objects.get(pk=patient_id)
    patient.date_of_birth = form.cleaned_data['patient_date_of_birth']
    patient.place_of_birth = form.cleaned_data['patient_place_of_birth']
    patient.social_security_number = form.cleaned_data['patient_social_security_number']
    patient.health_issues = form.cleaned_data['patient_health_issues']
    patient.save()

    person = patient.basic_info
    person.first_name = form.cleaned_data['patient_first_name']
    person.last_name = form.cleaned_data['patient_last_name']
    person.phone_number = form.cleaned_data['patient_phone_number']
    person.address = form.cleaned_data['patient_address']
    person.save()

    doctor = patient.primary_care_doctor
    doctor.first_name = form.cleaned_data['doctor_first_name']
    doctor.last_name = form.cleaned_data['doctor_last_name']
    doctor.phone_number = form.cleaned_data['doctor_phone_number']
    doctor.address = form.cleaned_data['doctor_address']
    doctor.save()

    emergency_contact = patient.emergency_contact
    emergency_contact.first_name = form.cleaned_data['emergency_contact_first_name']
    emergency_contact.last_name = form.cleaned_data['emergency_contact_last_name']
    emergency_contact.phone_number = form.cleaned_data['emergency_contact_phone_number']
    emergency_contact.address = form.cleaned_data['emergency_contact_address']
    emergency_contact.save()

    insurance_provider = patient.insurance_provider
    insurance_provider.name = form.cleaned_data['insurance_name']
    insurance_provider.phone_number = form.cleaned_data['insurance_phone_number']
    insurance_provider.address = form.cleaned_data['insurance_address']
    insurance_provider.save()

    request.session['edit_patient_success'] = True
    return http.HttpResponseRedirect(request.path)

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
    '''Allows user to change their password.'''
    message = ''

    if "POST" == request.method:
        form = models.ChangePasswordForm(request.POST)
        if form.is_valid():
            user       = request.user
            old_pass   = form.cleaned_data['old_password']
            new_pass_1 = form.cleaned_data['new_password_1']
            new_pass_2 = form.cleaned_data['new_password_2']

            if new_pass_1 == new_pass_2 and user.check_password(old_pass):
                user.set_password(new_pass_1)
                user.save()
                message = 'Password changed.'
            else:
                message = 'Password not changed.'
    else:
        form = models.ChangePasswordForm()

    tplate = template.loader.get_template('mhs/change_password.html')
    ctext = template.RequestContext(
        request,
        {
            'form': form,
            'message': message,
        }
    )
    return http.HttpResponse(tplate.render(ctext))
