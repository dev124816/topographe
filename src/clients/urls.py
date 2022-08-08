from django.urls import path, include
from clients.router import router


app_name = 'clients'
urlpatterns = [
    path('', include(router.urls)),
]