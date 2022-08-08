from django.contrib import admin
from django.urls import path, re_path, include
from django.views.generic import TemplateView
from django.views.static import serve
from django.conf import settings 


admin.site.site_header = 'Golden Geo Administration'

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/accounts/', include('rest_auth.urls')),
    path('api/clients/', include('clients.urls')),
    path('api/documents/', include('documents.urls')),
    path('api/financement/', include('financement.urls')),
    re_path(r'^media/(?P<path>.*)$', serve, {'document_root': settings.MEDIA_ROOT}),
    re_path(r'^service-worker.js', TemplateView.as_view(template_name="service-worker.js", content_type='application/javascript'), name='service-worker.js'),
    re_path(r'^manifest.json', TemplateView.as_view(template_name="manifest.json", content_type='application/json'), name='manifest.json'),
    re_path(r'.*', TemplateView.as_view(template_name='index.html'))
]
