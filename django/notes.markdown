django basics
=============

Some good guides to django [are](https://docs.djangoproject.com/en/1.4/)
[available](http://www.djangobook.com/en/2.0/index.html). The django project
[documents](https://docs.djangoproject.com/en/dev/ref/django-admin/) the
`django-admin.py` and `manage.py` commands.

    # Remember, the built-in webserver is NOT appropriate for production use.
    django-admin.py startproject site_xyz   # New project with default settings.
    python2.7 manage.py runserver           # localhost:8000
    python2.7 manage.py runserver 8001      # localhost:8001
    python2.7 manage.py runserver 0.0.0.0:8002  # all:8002
    python2.7 manage.py shell               # For e.g. creating a user.
    python2.7 manage.py dbshell             # Reads ENGINE, creates connection.
    python2.7 manage.py diffsettings        # Diff settings.py against defaults.

`settings.py` should be edited. You'll want to read through the entire file. For
starters, you should look at:

* `ROOT_URLCONF`
* `TEMPLATE_DIRS`
* `TIME_ZONE` (e.g. `America/New_York`)

Database tables need to be created for each of the `INSTALLED_APPS`. The
`syncdb` command will never alter an already-created table.

    python2.7 manage.py syncdb

When django receives a request for a web page, it imports `ROOT_URLCONF` (by
convention, `<project_name>.urls.py`) and evaluates `urlpatterns`. If a match
is found, the appropriate "view" function is called.

    # If the regex matches, views.hello will be called, not hello.
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

django models
=============

The [official django documentation](https://docs.djangoproject.com/en/1.4/ref/models/fields/)
details the field types and field options available to you. The django book also
provides excellent guides on how to use
[models](http://www.djangobook.com/en/2.0/chapter05.html) and
[forms](http://www.djangobook.com/en/2.0/chapter07.html) (the typical way of
querying and populating a database).

You don't need to create an app to use django. However, "if you're using
Django's database layer (models), you must create a Django app. Models must live
within apps." You can create an app manually, or you can use `manage.py`.

    $ python2.7 manage.py startapp foo
    $ touch foo/urls.py
    $ tree foo
    foo
    |-- __init__.py
    |-- models.py
    |-- tests.py
    |-- urls.py
    '-- views.py

The models.py file contains a series of class definitions. For example:

    from django.db import models
    class Author(models.Model):
        first_name = models.CharField(max_length=30)
        last_name = models.CharField(max_length=40)
        email = models.EmailField()

An app must be added to a project before it can be used.

    INSTALLED_APPS = (
        'my_project.foo',
    )

You can then validate your models, inspect the resultant SQL statements, create
the corresponding database tables, and inspect the changes in the database
itself.

    python2.7 manage.py validate
    python2.7 manage.py sqlall foo
    python2.7 manage.py syncdb
    python2.7 manage.py dbshell

If you make changes to a Django model, you'll need to make the same changes
inside your database to keep your database consistent with the model. `syncdb`
does not sync changes in models or deletions of models; if you make a change to
a model or delete a model, and you want to update the database, syncdb will not
handle that.

FastCGI
=======

The django docs outline
[how to](https://docs.djangoproject.com/en/dev/howto/deployment/fastcgi/) set up
FastCGI in detail.

As a prerequisite, you'll need to install flup, a Python library for dealing
with FastCGI. You can then start a server on either a TCP port or a Unix domain
socket.

    python2.7 manage.py runfcgi method=threaded host=127.0.0.1 port=4000 \
    daemonize=false debug=true
