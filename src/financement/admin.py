from django.contrib import admin
from financement.models import Financement


@admin.register(Financement)
class FinancementAdmin(admin.ModelAdmin):
    list_display = ['id', 'utilisateur', 'client', 'avance_1', 'date_de_avance_1', 'avance_2', 'date_de_avance_2', 'reste', 'mode', 'ajoute_le', 'modifie_le']
    search_fields = ['id']
    def save_model(self, request, obj, form, change):
        if request.method == 'POST':
            obj.utilisateur = request.user
            obj.save()
