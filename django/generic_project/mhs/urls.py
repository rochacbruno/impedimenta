from django.conf.urls import patterns, url, include

urlpatterns = patterns('mhs.views',
    url(r'^$', 'home_redirect'),
    url(r'^home/$', 'home'),
    url(r'^login/$', 'login'),
    url(r'^logout/$', 'logout'),
    url(r'^find_patient/$', 'find_patient'),
    url(r'^add_patient/$', 'add_patient'),
    url(r'^edit_patient/$', 'edit_patient'),
    url(r'^gen_report/$', 'gen_report'),
    url(r'^change_password/$', 'change_password'),
    url(r'^find_user/$', 'find_user'),
    url(r'^edit_user/$', 'edit_user'),
)
