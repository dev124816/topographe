from django.contrib import admin
from clients.models import (
    Cadastre,
    Client
)


@admin.register(Cadastre)
class CadastreAdmin(admin.ModelAdmin):
    list_display = ['id', 'utilisateur', 'nom', 'ajoute_le', 'modifie_le']
    search_fields = ['nom']
    def save_model(self, request, obj, form, change):
        if request.method == 'POST':
            obj.utilisateur = request.user
            obj.save()


@admin.register(Client)
class ClientAdmin(admin.ModelAdmin):
    list_display = ['id', 'utilisateur', 'numero_du_document', 'propriete_dite', 'titre_fonciere', 'nature', 'cadastre', 'nom', 'telephone', 'ref_proprietaire_1', 'ref_proprietaire_2', 'ajoute_le', 'modifie_le']
    search_fields = ['id', 'numero_de_ordre']
    def save_model(self, request, obj, form, change):
        if request.method == 'POST':
            obj.utilisateur = request.user
            obj.save()
            