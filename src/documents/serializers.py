from rest_framework import serializers
from documents.models import Dossier
from django.contrib.auth.models import User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'username'
        ]
        extra_kwargs = {
            'username': {'validators': []}
        }


class DossierSerializer(serializers.ModelSerializer):
    utilisateur = UserSerializer()
    agent_de_terrain = UserSerializer()
    agent_de_bureau = UserSerializer()

    def create(self, validated_data):
        dossier = Dossier.objects.create(
            utilisateur=User.objects.get(username=str(validated_data.get('utilisateur', {}).get('username')).lower()),
            etat=validated_data.get('etat'),
            agent_de_terrain=User.objects.get(username=str(validated_data.get('agent_de_terrain', {}).get('username')).lower()),
            agent_de_bureau=User.objects.get(username=str(validated_data.get('agent_de_bureau', {}).get('username')).lower()),
            date_de_envoie=validated_data.get('date_de_envoie'),
            date_de_recepisse=validated_data.get('date_de_recepisse')
        )
        dossier.save()
        return dossier

    def update(self, instance, validated_data):
        instance.utilisateur = User.objects.get(username=str(validated_data.get('utilisateur', {}).get('username', instance.utilisateur.username)).lower())
        instance.etat = validated_data.get('etat', instance.etat)
        instance.agent_de_terrain = User.objects.get(username=str(validated_data.get('agent_de_terrain', {}).get('username', instance.agent_de_terrain.username)).lower())
        instance.agent_de_bureau = User.objects.get(username=str(validated_data.get('agent_de_bureau', {}).get('username', instance.agent_de_bureau.username)).lower())
        instance.date_de_envoie = validated_data.get('date_de_envoie', instance.date_de_envoie)
        instance.date_de_recepisse = validated_data.get('date_de_recepisse', instance.date_de_recepisse)
        instance.save()
        return instance

    class Meta:
        model = Dossier
        fields = [
            'id',
            'utilisateur',
            'etat',
            'agent_de_terrain',
            'agent_de_bureau',
            'date_de_envoie',
            'date_de_recepisse',
            'ajoute_le',
            'modifie_le'
        ]
