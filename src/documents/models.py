from django.db import models
from django.contrib.auth.models import User


class Dossier(models.Model):
    utilisateur = models.ForeignKey(User, on_delete=models.CASCADE, editable=False, null=True, blank=True)
    etat = models.CharField(max_length=250, choices=[
        ('En cours', 'En cours'),
        ('Terrain', 'Terrain'),
        ('Bureau', 'Bureau'),
        ('Instance', 'Instance'),
        ('Complet', 'Complet'),
        ('Cadastre', 'Cadastre'),
        ('Scanner', 'Scanner')
    ], null=True, blank=True)
    agent_de_terrain = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True, related_name="agent_de_terrain")
    agent_de_bureau = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True, related_name="agent_de_bureau")
    date_de_envoie = models.DateField(null=True, blank=True)
    date_de_recepisse = models.DateField(null=True, blank=True)
    ajoute_le = models.DateTimeField(auto_now_add=True)
    modifie_le = models.DateTimeField(auto_now=True)

    def __str__(self):
      return 'Dossier ' + str(self.id)  
