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
            'body': message
        }
    )
    return http.HttpResponse(tplate.render(ctext))
