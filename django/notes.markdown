notes on django
===============

Some good guides to django [are](https://docs.djangoproject.com/en/1.4/intro/)
[available](http://www.djangobook.com/en/2.0/index.html). To create a new django
project:

    django-admin.py startproject site_xyz

By default, the development webserver runs on localhost:8000. You can view the
full documentation on the `django-admin.py` and `manage.py` commands
[here](https://docs.djangoproject.com/en/dev/ref/django-admin/).

    python2.7 manage.py runserver
    python2.7 manage.py runserver 8001
    python2.7 manage.py runserver 0.0.0.0:8002

`settings.py` should be edited. Assuming the use of SQLite, edit `ENGINE` and
`NAME` in the `DATABASES` dict. `NAME` should be an absolute path. Also of
interest are:

* `TIME_ZONE` (e.g. `America/New_York`)
* `INSTALLED_APPS`
* `ROOT_URLCONF`
* `DEBUG`
* `TEMPLATE_DIRS`

Database tables need to be created for each of the `INSTALLED_APPS`. The
`syncdb` command will never alter an already-created table.

    python2.7 manage.py syncdb

When django receives a request for a web page, it imports `ROOT_URLCONF` (by
convention, `<project_name>.urls.py`) and evaluates `urlpatterns`. If a match
is found, the appropriate view (just a function) is called.

    urlpatterns = patterns('views',
        url(r'^$', index),
        url(r'^hello/$', hello),
    )

Views render a response.

    def hello(request):
        return http.HttpResponse("Hello world")

If `TEMPLATE_DIRS` is specified, a view may use a template.

    def echo(request, message):
        tplate = template.loader.get_template('default.html')
        ctext = template.Context({
            'title': 'Echo',
            'body': message
        })
        return http.HttpResponse(tplate.render(ctext))

It's possible to capture values from URLs and pass them to views. The values may
be named, too.

    # Unnamed.
    url(r'^time/plus/(-?\d{1,3})/$', views.time_plus),
    def time_plus(request, hour_offset):
    # Named.
    url(r'^echo/(?P<message>.*)/$', 'echo'),
    def echo(request, message):
