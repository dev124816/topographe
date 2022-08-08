from django.urls import path, include
from financement.router import router


app_name = 'financement'
urlpatterns = [
    path('', include(router.urls)),
]
