from rest_framework import routers
from clients.views import ClientViewSet


router = routers.DefaultRouter()
router.register(r'clients', ClientViewSet, basename='Client')
