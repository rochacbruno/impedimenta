'''Defines which URLs comprise the Modern Hospital Systems django app.'''
from django.conf.urls import patterns, url

# (Invalid name "urlpatterns" for type constant) pylint: disable-msg=C0103
urlpatterns = patterns('mhs.views',
    url(r'^$', 'home_redirect'),
    url(r'^home/$', 'home'),
    url(r'^login/$', 'login'),
    url(r'^logout/$', 'logout'),
    url(r'^find_patient/$', 'find_patient'),
    url(r'^add_patient/$', 'add_patient'),
    url(r'^edit_patient/(?P<patient_id>\d+)/$', 'edit_patient'),
    url(r'^gen_report/$', 'gen_report'),
    url(r'^change_password/$', 'admin_redirect'),
    url(r'^manage_users/$', 'admin_redirect'),
)
