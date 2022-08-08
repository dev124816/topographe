from django.db import models
from django.core.validators import MinValueValidator
from django.contrib.auth.models import User
from clients.models import Client


class Financement(models.Model):
    utilisateur = models.ForeignKey(User, on_delete=models.CASCADE, editable=False, null=True, blank=True)
    client = models.ForeignKey(Client, on_delete=models.CASCADE)
    avance_1 = models.DecimalField(max_digits=12, decimal_places=2, validators=[MinValueValidator(0.0)])
    date_de_avance_1 = models.DateField()
    avance_2 = models.DecimalField(max_digits=12, decimal_places=2, validators=[MinValueValidator(0.0)], null=True, blank=True)
    date_de_avance_2 = models.DateField(null=True, blank=True)
    reste = models.PositiveIntegerField(null=True, blank=True)
    mode = models.CharField(max_length=250, choices=[
        ('Chèque', 'Chèque'),
        ('Espèce', 'Espèce'),
        ('Virement', 'Virement')
    ])
    ajoute_le = models.DateTimeField(auto_now_add=True)
    modifie_le = models.DateTimeField(auto_now=True)

    def __str__(self):
        return 'Financement ' + str(self.id)