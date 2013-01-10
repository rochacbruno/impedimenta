from django.conf.urls import patterns, url, include

urlpatterns = patterns('decoupled_app.views',
    url(r'^$', 'index'),
)
