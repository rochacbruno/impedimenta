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
