'''Allows django to return customized HTTP responses.

After reading through the ``ROOT_URLCONF`` file, django will choose a view to
call. At a minimum, a view must accept a HttpRequest object. ::

    hello(request=<HttpRequest object>)

Views can accept other arguments, too. ::

    time_plus(request=<HttpRequest object>, hour_offset='23')

Views should always render an HttpResponse. ::

    return http.HttpResponse("Hello, world!")

You can use templates from ``TEMPLATE_DIRS``.

    tplate = template.loader.get_template('default.html')

'''
# For creating http.HttpResponse objects.
from django import http
# Used to spice up the logic of some views.
import datetime
# Allows templates to be used.
from django import template

def index(request):
    return http.HttpResponse("At index page.")

def hello(request):
    return http.HttpResponse("Hello, world!")

def time(request):
    html = "<html><body>{}</body></html>".format(
        datetime.datetime.now()
    )
    return http.HttpResponse(html)

def time_plus(request, hour_offset):
    try:
        hour_offset = int(hour_offset)
    except ValueError:
        raise http.Http404()
    time = datetime.datetime.now()
    html = "<html><body>In {} hours, it will be {}.</html></body>".format(
        hour_offset, time + datetime.timedelta(hours = hour_offset)
    )
    return http.HttpResponse(html)

def echo(request, message):
    tplate = template.loader.get_template('default.html')
    ctext = template.Context({
        'title': 'Echo',
        'body': message
    })
    return http.HttpResponse(tplate.render(ctext))
