from django.db import models
from django.contrib.auth.models import User
from documents.models import Dossier


class Cadastre(models.Model):
    utilisateur = models.ForeignKey(User, on_delete=models.CASCADE, editable=False, null=True, blank=True)
    nom = models.CharField(max_length=250, unique=True)  
    ajoute_le = models.DateTimeField(auto_now_add=True)
    modifie_le = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.nom


class Client(models.Model):
    utilisateur = models.ForeignKey(User, on_delete=models.CASCADE, editable=False, null=True, blank=True)
    numero_du_document = models.ForeignKey(Dossier, on_delete=models.CASCADE) 
    propriete_dite = models.CharField(max_length=250, null=True, blank=True)
    titre_fonciere = models.CharField(max_length=250, null=True, blank=True) 
    nature = models.CharField(max_length=250, choices=[
        ('Copropriété', 'Copropriété'),
        ('Mise à jour', 'Mise à jour'),
        ('Copropriété et mise à jour', 'Copropriété et mise à jour'),
        ('Copropriété, mise à jour, et fusion', 'Copropriété, mise à jour, et fusion'),
        ('Morcellement', 'Morcellement'),
        ('Fusion', 'Fusion'),
        ('Morcellement et fusion', 'Morcellement et fusion'),
        ('Morcellement et mise à jour', 'Morcellement et mise à jour'),
        ('Délimitation', 'Délimitation'),
        ('Plan cote', 'Plan cote'),
        ('Implantation', 'Implantation'),
        ('Rétablissement', 'Rétablissement'),
        ('Avenant', 'Avenant')
    ], null=True, blank=True)
    cadastre = models.ForeignKey(Cadastre, on_delete=models.CASCADE, null=True, blank=True)
    nom = models.CharField(max_length=250, null=True, blank=True)
    telephone = models.PositiveIntegerField(null=True, blank=True)
    ref_proprietaire_1 = models.PositiveIntegerField(unique=True, null=True, blank=True)
    ref_proprietaire_2 = models.CharField(max_length=250, unique=True, null=True, blank=True)
    ajoute_le = models.DateTimeField(auto_now_add=True)
    modifie_le = models.DateTimeField(auto_now=True)

    def __str__(self):
      return 'Client ' + str(self.id)  
