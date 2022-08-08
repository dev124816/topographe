from rest_framework import serializers
from django.contrib.auth.models import User
from clients.models import (
    Cadastre,
    Client 
)
from documents.models import Dossier


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'username'
        ]
        extra_kwargs = {
            'username': {'validators': []}
        }


class CadastreSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cadastre
        fields = [
            'nom'
        ]
        extra_kwargs = {
            'nom': {'validators': []}
        }


class DossierSerializer(serializers.ModelSerializer):
    class Meta:
        model = Dossier
        fields = [
            'id'
        ]
        extra_kwargs = {
            'id': {
                'validators': [], 
                'read_only': False
            }
        }


class ClientSerializer(serializers.ModelSerializer):
    utilisateur = UserSerializer()
    numero_du_document = DossierSerializer()
    cadastre = CadastreSerializer()

    def create(self, validated_data):
        cadastre, cadastre_created = Cadastre.objects.get_or_create(nom=str(validated_data.get('cadastre', {}).get('nom')).lower())
        client = Client.objects.create(
            utilisateur=User.objects.get(username=str(validated_data.get('utilisateur', {}).get('username')).lower()),
            numero_du_document=Dossier.objects.get(id=int(validated_data.get('numero_du_document', {}).get('id'))),
            propriete_dite=validated_data.get('propriete_dite'),
            titre_fonciere=validated_data.get('titre_fonciere'),
            nature=validated_data.get('nature'),
            cadastre=cadastre,
            nom=validated_data.get('nom'),
            telephone=validated_data.get('telephone'),
            ref_proprietaire_1=validated_data.get('ref_proprietaire_1'),
            ref_proprietaire_2=validated_data.get('ref_proprietaire_2')
        )
        client.save()
        return client

    def update(self, instance, validated_data):
        cadastre, cadastre_created = Cadastre.objects.get_or_create(nom=str(validated_data.get('cadastre', {}).get('nom', instance.cadastre.nom)).lower())
        instance.utilisateur = User.objects.get(username=str(validated_data.get('utilisateur', {}).get('username', instance.utilisateur.username)).lower())
        instance.numero_du_document = Dossier.objects.get(id=int(validated_data.get('numero_du_document', {}).get('id', instance.numero_du_document.id)))
        instance.propriete_dite = validated_data.get('propriete_dite', instance.propriete_dite)
        instance.titre_fonciere = validated_data.get('titre_fonciere', instance.titre_fonciere)
        instance.nature = validated_data.get('nature', instance.nature)
        instance.cadastre = cadastre
        instance.nom = validated_data.get('nom', instance.nom)
        instance.telephone = validated_data.get('telephone', instance.telephone)
        instance.ref_proprietaire_1 = validated_data.get('ref_proprietaire_1', instance.ref_proprietaire_1)
        instance.ref_proprietaire_2 = validated_data.get('ref_proprietaire_2', instance.ref_proprietaire_2)
        instance.save()
        return instance

    class Meta:
        model = Client
        fields = [
            'id',
            'utilisateur',
            'numero_du_document',
            'propriete_dite',
            'titre_fonciere',
            'nature',
            'cadastre',
            'nom',
            'telephone',
            'ref_proprietaire_1',
            'ref_proprietaire_2',
            'ajoute_le',
            'modifie_le'
        ]
