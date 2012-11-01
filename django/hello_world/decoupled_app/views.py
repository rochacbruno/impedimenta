# For creating http.HttpResponse objects.
from django import http
# Allows templates to be used.
from django import template

def index(request):
    tplate = template.loader.get_template('default.html')
    message = 'You\'ve reached a decoupled app!'
    ctext = template.Context({
        'title': 'index',
        'body': message
    })
    return http.HttpResponse(tplate.render(ctext))
