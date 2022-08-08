from rest_framework import viewsets
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from financement.models import Financement
from financement.serializers import FinancementSerializer

    
class FinancementViewSet(viewsets.ModelViewSet):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]
    queryset = Financement.objects.all().order_by('-id')
    serializer_class = FinancementSerializer
