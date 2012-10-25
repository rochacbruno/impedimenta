from django import http

def index(request):
    return http.HttpResponse("At index page.")

def hello(request):
    return http.HttpResponse("Hello world")
