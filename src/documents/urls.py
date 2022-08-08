from django.urls import path, include
from documents.router import router


app_name = 'documents'
urlpatterns = [
    path('', include(router.urls)),
]