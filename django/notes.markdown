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

`settings.py` should be edited. Of interest are:

* `DATABASES` dict
  * `ENGINE`
  * `NAME` (should be an absolute path)
* `DEBUG`
* `INSTALLED_APPS`
* `ROOT_URLCONF`
* `TEMPLATE_DIRS`
* `TIME_ZONE` (e.g. `America/New_York`)

Database tables need to be created for each of the `INSTALLED_APPS`. The
`syncdb` command will never alter an already-created table.

    python2.7 manage.py syncdb

When django receives a request for a web page, it imports `ROOT_URLCONF` (by
convention, `<project_name>.urls.py`) and evaluates `urlpatterns`. If a match
is found, the appropriate view (just a function) is called.

    # If the regex matches, views.hello will be called.
    urlpatterns = patterns('views',
        url(r'^hello/$', hello),
    )
    # The additional urls here don't use the "views" prefix as above.
    urlpatterns += patterns('',
        url(r'^admin/', include(admin.site.urls)),
    )

    # A minimal view.
    def hello(request):
        return http.HttpResponse("Hello world")

It's possible to capture values from URLs and pass them to views. The values may
be named. A view may use a template if `TEMPLATE_DIRS` is specified.

    # These two URLs capture anonymous and named variables, respectively.
    url(r'^time/plus/(-?\d{1,3})/$', time_plus)
    url(r'^echo/(?P<message>.*)/$', 'echo')

    # Demonstrates usage of a template.
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
