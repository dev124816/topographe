from django.contrib import admin
from documents.models import Dossier


@admin.register(Dossier)
class DossierAdmin(admin.ModelAdmin):
    list_display = ['id', 'utilisateur', 'etat', 'agent_de_terrain', 'agent_de_bureau', 'date_de_envoie', 'date_de_recepisse', 'ajoute_le', 'modifie_le']
    search_fields = ['id']
    def save_model(self, request, obj, form, change):
        if request.method == 'POST':
            obj.utilisateur = request.user
            obj.save()
            