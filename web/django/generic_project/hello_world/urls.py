'''Given a URL, chooses a view with which to render a response.

``patterns`` and ``urls`` are the minimum necessary imports to define a
``urlpatterns`` variable. ``include`` allows you to reference another URLConf
file. You can match part of a URL pattern here and pass the remaining portion of
the url to the referenced URLConf.

One can extract named arguments from a URL, which are then passed to a view. ::

    url(r'^echo/(?P<message>.*)/$', 'echo'),

'''
from django.conf.urls import patterns, url, include

# For the admin interface.
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('hello_world.views',
    url(r'^$',                        'index'),
    url(r'^echo/$',                   'echo_instructions'),
    url(r'^echo/(?P<message>.*)/$',   'echo'),
    url(r'^hello/$',                  'hello'),
    url(r'^notes/$',                  'notes'),
    url(r'^time/$',                   'time'),
    url(r'^time/plus/(-?\d{1,3})/$',  'time_plus'),
    url(r'^admin/', include(admin.site.urls)),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
)
urlpatterns += patterns('',
    url(r'^decoupled_app/', include('decoupled_app.urls')),
    url(r'^mhs/',           include('mhs.urls')),
)
