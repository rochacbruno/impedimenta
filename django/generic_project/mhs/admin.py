from django.contrib import admin
from mhs import models

admin.site.register(models.Person)
admin.site.register(models.InsuranceProvider)
admin.site.register(models.Patient)
admin.site.register(models.Visit)
