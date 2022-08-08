from rest_framework import routers
from financement.views import FinancementViewSet


router = routers.DefaultRouter()
router.register(r'financement', FinancementViewSet, basename='Financement')
