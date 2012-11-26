from django.db import models

class Patient(models.Model):
    '''A patient of Modern Hospital Systems.'''
    first_name = models.CharField(max_length = 30)
    last_name = models.CharField(max_length = 30)
    address = models.CharField(max_length = 100)
    birth_date = models.DateField()
    birth_place = models.CharField(max_length = 100)
    social_security = models.CharField(max_length = 9)
    health_issues = models.TextField()
    number = models.CharField(max_length = 25)

    def __unicode__(self):
        return '{} {}'.format(first_name, last_name)

class EmergencyContact(models.Model):
    '''An emergency contact for a ``Patient``.'''
    first_name = models.CharField(max_length = 30)
    last_name = models.CharField(max_length = 30)
    number = models.CharField(max_length = 25)
    patient = models.ForeignKey(Patient)

    def __unicode__(self):
        return '{} {}'.format(first_name, last_name)

class Doctor(models.Model):
    '''A primary care doctor for a ``Patient``.'''
    first_name = models.CharField(max_length = 30)
    last_name = models.CharField(max_length = 30)
    address = models.CharField(max_length = 100)
    number = models.CharField(max_length = 25)
    patient = models.ForeignKey(Patient)

    def __unicode__(self):
        return '{} {}'.format(first_name, last_name)

class InsuranceProvider(models.Model):
    '''An insurance provider for a ``Patient``.'''
    name = models.CharField(max_length = 100)
    address = models.CharField(max_length = 100)
    number = models.CharField(max_length = 25)
    patient = models.ForeignKey(Patient)

    def __unicode__(self):
        return self.name

class Visit(models.Model):
    '''Represents a single visit by a ``Patient`` to an MHS location.'''
    date = models.DateTimeField()
    location = models.CharField(max_length = 50)
    reason_for_visit = models.CharField(max_length = 30)
    notes = models.TextField()
    patient = models.ForeignKey(Patient)

    def __unicode__(self):
        return self.reason_for_visit
