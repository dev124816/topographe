from rest_framework import routers
from documents.views import DossierViewSet


router = routers.DefaultRouter()
router.register(r'documents', DossierViewSet, basename='Dossier')
