from rest_framework import viewsets
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from documents.models import Dossier
from documents.serializers import DossierSerializer

    
class DossierViewSet(viewsets.ModelViewSet):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]
    queryset = Dossier.objects.all().order_by('-id')
    serializer_class = DossierSerializer
