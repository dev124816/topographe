from rest_framework import serializers
from financement.models import Financement
from django.contrib.auth.models import User
from clients.models import Client


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'username'
        ]
        extra_kwargs = {
            'username': {'validators': []}
        }


class ClientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Client
        fields = [
            'id',
        ]
        extra_kwargs = {
            'id': {
                'validators': [], 
                'read_only': False
            }
        }


class FinancementSerializer(serializers.ModelSerializer):
    utilisateur = UserSerializer()
    client = ClientSerializer()

    def create(self, validated_data):
        financement = Financement.objects.create(
            utilisateur=User.objects.get(username=str(validated_data.get('utilisateur', {}).get('username')).lower()),
            client=Client.objects.get(id=int(validated_data.get('client', {}).get('id'))),
            avance_1=validated_data.get('avance_1'),
            date_de_avance_1=validated_data.get('date_de_avance_1'),
            avance_2=validated_data.get('avance_2'),
            date_de_avance_2=validated_data.get('date_de_avance_2'),
            reste=validated_data.get('reste'),
            mode=validated_data.get('mode')
        )
        financement.save()
        return financement

    def update(self, instance, validated_data):
        instance.utilisateur = User.objects.get(username=str(validated_data.get('utilisateur', {}).get('username', instance.utilisateur.username)).lower())
        instance.client = Client.objects.get(id=int(validated_data.get('client', {}).get('id', instance.client.id)))
        instance.avance_1 = validated_data.get('avance_1', instance.avance_1)
        instance.date_de_avance_1 = validated_data.get('date_de_avance_1', instance.date_de_avance_1)
        instance.avance_2 = validated_data.get('avance_2', instance.avance_2)
        instance.date_de_avance_2 = validated_data.get('date_de_avance_2', instance.date_de_avance_2)
        instance.reste = validated_data.get('reste', instance.reste)
        instance.mode = validated_data.get('mode', instance.mode)
        instance.save()
        return instance
    
    class Meta:
        model = Financement
        fields = [
            'id',
            'utilisateur',
            'client',
            'avance_1',
            'date_de_avance_1',
            'avance_2',
            'date_de_avance_2',
            'reste',
            'mode',
            'ajoute_le',
            'modifie_le'
        ]
