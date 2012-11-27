'''Defines the data models (database tables) used in the MHS app.'''
from django.db import models
from django import forms
from django.forms import widgets

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
    basic_info = models.OneToOneField(Person, related_name = 'basic_info')
    birth_date = models.DateField()
    birth_place = models.CharField(max_length = 100)
    social_security = models.CharField(max_length = 9)
    health_issues = models.TextField()
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

class Visit(models.Model):
    '''Represents a single visit by a ``Patient`` to an MHS location.'''
    date = models.DateTimeField()
    location = models.CharField(max_length = 50)
    reason_for_visit = models.CharField(max_length = 30)
    notes = models.TextField()
    patient = models.ForeignKey(Patient)

    def __unicode__(self):
        return '{}, {}'.format(self.patient, self.date)
