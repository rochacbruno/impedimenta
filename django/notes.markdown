notes on django
===============

Some good guides to django [are](https://docs.djangoproject.com/en/1.4/intro/)
[available](http://www.djangobook.com/en/2.0/index.html). By default, the
development webserver runs on localhost:8000. You can view the full
documentation on the `django-admin.py` and `manage.py` commands
[here](https://docs.djangoproject.com/en/dev/ref/django-admin/).

    django-admin.py startproject site_xyz
    python2.7 manage.py runserver
    python2.7 manage.py runserver 8001
    python2.7 manage.py runserver 0.0.0.0:8002

`settings.py` should be edited. Assuming the use of SQLite, edit `ENGINE` and
`NAME` in the `DATABASES` dict. `NAME` should be an absolute path. Also of
interest are:

* `DEBUG`
* `INSTALLED_APPS`
* `ROOT_URLCONF`
* `TEMPLATE_DIRS`
* `TIME_ZONE` (e.g. `America/New_York`)

Database tables need to be created for each `INSTALLED_APPS`. The `syncdb`
command will never alter an already-created table.

    python2.7 manage.py syncdb

When django receives a request for a web page, it imports `ROOT_URLCONF` (by
convention, `<project_name>.urls.py`) and evaluates `urlpatterns`. If a match
is found, the appropriate view (just a function) is called.

    # The ROOT_URLCONF or one of the modules it imports.
    urlpatterns = patterns('views',
        url(r'^$', index),
        url(r'^hello/$', hello),
    )
    urlpatterns += patterns('',
        url(r'^admin/', include(admin.site.urls)),
    )

    # A view called by django when one of the url objects matches.
    def hello(request):
        return http.HttpResponse("Hello world")

It's possible to capture values from URLs and pass them to views. The values may
be named. If `TEMPLATE_DIRS` is specified, a view may use a template.

    # The two URLs capture anonymous and named variables, respectively.
    url(r'^time/plus/(-?\d{1,3})/$', views.time_plus),
    url(r'^echo/(?P<message>.*)/$', 'echo'),

    # Demonstrates usage of template.
    def echo(request, message):
        tplate = template.loader.get_template('default.html')
        ctext = template.Context({
            'title': 'Echo',
            'body': message
        })
        return http.HttpResponse(tplate.render(ctext))

If you set `DEBUG = False` in your settings.py file, you should define a
`404.html` file in the root of your templates directory. Django will use the
template automatically.
