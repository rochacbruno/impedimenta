'''Defines the data models (database tables) used in the MHS app.'''
from django.db import models
from django import forms
import re

class Person(models.Model):
    '''Basic information about a person and their contact info.'''
    first_name = models.CharField(max_length = 30)
    last_name = models.CharField(max_length = 30)
    phone_number = models.CharField(max_length = 25)
    address = models.CharField(max_length = 100)

    def __unicode__(self):
        return '{} {}'.format(self.first_name, self.last_name)

class InsuranceProvider(models.Model):
    '''An insurance provider for a ``Patient``.'''
    name = models.CharField(max_length = 100)
    address = models.CharField(max_length = 100)
    phone_number = models.CharField(max_length = 25)

    def __unicode__(self):
        return self.name

class Patient(models.Model):
    '''A patient of Modern Hospital Systems.'''
    date_of_birth = models.DateField()
    place_of_birth = models.CharField(max_length = 100)
    social_security_number = models.CharField(max_length = 9)
    health_issues = models.TextField()
    basic_info = models.OneToOneField(
        Person,
        related_name = 'basic_info'
    )
    emergency_contact = models.OneToOneField(
        Person,
        related_name = 'emergency_contact',
    )
    primary_care_doctor = models.OneToOneField(
        Person,
        related_name = 'primary_care_doctor',
    )
    insurance_provider = models.OneToOneField(
        InsuranceProvider,
        related_name = 'insurance_provider',
    )

    def __unicode__(self):
        return unicode(self.basic_info)

class PatientForm(forms.Form):
    '''A form which can be used to populate a ``Person`` object.'''

    # Info about the patient himself.
    patient_first_name = forms.CharField(max_length = 30)
    patient_last_name = forms.CharField(max_length = 30)
    patient_date_of_birth = forms.DateField()
    patient_phone_number = forms.CharField(
        max_length = 25,
        required = False,
    )
    patient_address = forms.CharField(
        max_length = 100,
        widget = forms.Textarea,
        required = False,
    )
    patient_place_of_birth = forms.CharField(
        max_length = 100,
        required = False,
    )
    patient_social_security_number = forms.CharField(
        max_length = 9,
        required = False,
    )
    patient_health_issues = forms.CharField(
        max_length = 1000,
        widget = forms.Textarea,
        required = False,
    )

    # The patient's emergency contact.
    emergency_contact_first_name = forms.CharField(
        max_length = 30,
        required = False,
    )
    emergency_contact_last_name = forms.CharField(
        max_length = 30,
        required = False,
    )
    emergency_contact_phone_number = forms.CharField(
        max_length = 25,
        required = False,
    )
    emergency_contact_address = forms.CharField(
        max_length = 100,
        widget = forms.Textarea,
        required = False,
    )

    # The patient's primary care doctor.
    doctor_first_name = forms.CharField(
        max_length = 30,
        required = False,
    )
    doctor_last_name = forms.CharField(
        max_length = 30,
        required = False,
    )
    doctor_phone_number = forms.CharField(
        max_length = 25,
        required = False,
    )
    doctor_address = forms.CharField(
        max_length = 100,
        widget = forms.Textarea,
        required = False,
    )

    # The patient's insurance.
    insurance_name = forms.CharField(
        max_length = 100,
        required = False,
    )
    insurance_phone_number = forms.CharField(
        max_length = 25,
        required = False,
    )
    insurance_address = forms.CharField(
        max_length = 100,
        widget = forms.Textarea,
        required = False,
    )

class PatientSearchForm(forms.Form):
    '''A form which can be used to search for a ``Person`` object.'''
    # Info about the patient himself.
    patient_first_name = forms.CharField(
        max_length = 30,
        required = False,
    )
    patient_last_name = forms.CharField(
        max_length = 30,
        required = False,
    )
    patient_date_of_birth_start = forms.DateField(
        required = False,
    )
    patient_date_of_birth_end = forms.DateField(
        required = False,
    )
    patient_social_security_number = forms.CharField(
        max_length = 9,
        required = False,
    )
    patient_phone_number = forms.CharField(
        max_length = 25,
        required = False,
    )

    def clean_patient_social_security_number(self):
        '''Ensures that ``self.social_security_number`` is valid.'''
        ssn = self.cleaned_data['patient_social_security_number']
        if 0 == len(ssn):
            return ssn
        if not re.search('^\d{9}$', ssn):
            raise forms.ValidationError("Must be a series of nine digits.")
        return ssn

    def clean_patient_phone_number(self):
        '''Ensures that ``self.patient_phone_number`` is valid.'''
        num = self.cleaned_data['patient_phone_number']
        if not re.search('^\d*$', num):
            raise forms.ValidationError("Must be a series of digits. (no dashes)")
        return num

class Visit(models.Model):
    '''Represents a single visit by a ``Patient`` to an MHS location.'''
    date = models.DateTimeField()
    location = models.CharField(max_length = 50)
    reason_for_visit = models.CharField(max_length = 30)
    notes = models.TextField()
    patient = models.ForeignKey(Patient)

    def __unicode__(self):
        return '{}, {}'.format(self.patient, self.date)

class ChangePasswordForm(forms.Form):
    '''A form which a user can use to change their password.'''
    old_password = forms.CharField(
        label = 'Old password:',
        widget = forms.PasswordInput,
        max_length = 30,
    )
    new_password_1 = forms.CharField(
        label = 'New password:',
        widget = forms.PasswordInput,
        max_length = 30,
    )
    new_password_2 = forms.CharField(
        label = 'New password (again):',
        widget = forms.PasswordInput,
        max_length = 30,
    )
