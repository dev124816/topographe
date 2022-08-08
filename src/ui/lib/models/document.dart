import 'package:flutter/foundation.dart';


class Document with ChangeNotifier {
  String utilisateur = '';
  String etat = '';
  String agentDeTerrain = '';
  String agentDeBureau = '';
  String dateDeEnvoie = '';
  String dateDeRecepisse = '';
  String ajouteLe = '';
  String modifieLe = '';
}
