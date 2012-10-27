from django import http
import datetime

def index(request):
    return http.HttpResponse("At index page.")

def hello(request):
    return http.HttpResponse("Hello world")

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
