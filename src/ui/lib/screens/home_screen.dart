import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topographe/config/styles.dart';
import 'package:topographe/config/config.dart';
import 'package:topographe/utils/utils.dart';
import 'package:topographe/widgets/layout.dart';
import 'package:topographe/widgets/header.dart';
import 'package:topographe/widgets/logo.dart';
import 'package:topographe/widgets/userbar.dart';
import 'package:topographe/widgets/sidebar.dart';
import 'package:topographe/widgets/sidebar_child.dart';
import 'package:topographe/widgets/footer.dart';
import 'package:topographe/widgets/button.dart';
import 'package:topographe/widgets/modal.dart';
import 'package:topographe/widgets/field.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  String? token;
  String model = 'clients';
  List<Map<String, dynamic>> data = [];
  Map<String, dynamic> fields = {};
  Map<String, dynamic> modal = {
    'visibility': false,
    'functionality': () => null,
    'title': "title",
    'content': const SizedBox(),
    'height': 600.0
  };
 
  void initState() {
    SharedPreferences.getInstance()
    .then((SharedPreferences preferences) {
      if (preferences.containsKey('token')) {
        setState(() {
          username = preferences.getString('username');
          token = preferences.getString('token');
        });

        getData('clients');
      } else {
        Navigator.popAndPushNamed(context, '/login'); 
      }
    });

    super.initState(); 
  }

  void logout() {
    post(Uri.parse(url + '/api/accounts/logout/'))
    .then((response) {
      if (response.statusCode == 200) {
        SharedPreferences.getInstance()
        .then((SharedPreferences preferences) {
          setState(() {
            username = '';
            token = '';
          });
      
          preferences.clear();

          Navigator.popAndPushNamed(context, '/login');
        });
      }
    });
  }

  void requestPostData(BoxConstraints constraints) {
    setState(() {
      modal['visibility'] = true;
      modal['title'] = 'Ajouter';
      modal['content'] = Container(
          width: constraints.maxWidth > 420.0 ? 400.0 : 200.0,
          child: GridView.count(
            crossAxisCount: constraints.maxWidth > 420.0 ? 2 : 1,
            crossAxisSpacing: 30.0,
            childAspectRatio: 2,
            children: generateModalFields().map((modalField) {
              return Field(
                label: modalField['label'], 
                onChanged: (value) => handleField(value, modalField['name']),
                labelFontSize: 15.0,
                labelFontWeight: FontWeight.w500,
                labelFontColor: Colors_.primaryLightFont,
                cursorColor: Colors_.primaryLightFont,
                keyboardType: modalField['keyboardType'],
                inputBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors_.primaryBorder,
                  ),
                  borderRadius: BorderRadius.circular(5.0)
                ),
                focusColor: Colors_.accent,
                fillColor: Colors_.primaryLightFont,
                hintText: modalField['hintText'],
                fontSize: 15.0,
                mainAxisAlignment: MainAxisAlignment.center
              );
            }).toList()
          ),
      );      
      modal['functionality'] = postData;
      modal['height'] = 600.0;      
    });

  }

  void requestPutData(int? id, BoxConstraints constraints) {
    if (id is Null) return;

    setState(() {
      modal['visibility'] = true;
      modal['title'] = 'Modifier';
      modal['content'] = Container(
          width: constraints.maxWidth > 420.0 ? 400.0 : 200.0,
          child: GridView.count(
            crossAxisCount: constraints.maxWidth > 420.0 ? 2 : 1,
            crossAxisSpacing: 30.0,
            childAspectRatio: 2,
            children: generateModalFields().map((modalField) {
              return Field(
                label: modalField['label'], 
                onChanged: (value) => handleField(value, modalField['name']),
                labelFontSize: 15.0,
                labelFontWeight: FontWeight.w500,
                labelFontColor: Colors_.primaryLightFont,
                cursorColor: Colors_.primaryLightFont,
                keyboardType: modalField['keyboardType'],
                inputBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors_.primaryBorder,
                  ),
                  borderRadius: BorderRadius.circular(5.0)
                ),
                focusColor: Colors_.accent,
                fillColor: Colors_.primaryLightFont,
                hintText: fields[modalField['name']] is Map<String, dynamic> ? fields[modalField['name']].values.toList()[0].toString() : fields[modalField['name']].toString(),
                hintTextColor: Colors_.primaryLightFont,
                fontSize: 15.0,
                mainAxisAlignment: MainAxisAlignment.center
              );
            }).toList()
          ),
      );      
      modal['functionality'] = () => putData(id);
      modal['height'] = 600.0;      
    });
  }

  void requestDeleteData(int? id) {
    if (id is Null) return;

    setState(() {
      modal['visibility'] = true;
      modal['title'] = 'Supprimer';
      modal['content'] = Container(
        alignment: Alignment.center,
        child: const Text('Voulez vous vraiment supprimer?',
          style: TextStyle(
            color: Colors_.primaryLightFont,
            fontWeight: FontWeight.w500,
            fontSize: 14.0
          )
        )
      );
      modal['functionality'] = () => deleteData(id);
      modal['height'] = 300.0;
    });

  }

  void getData([String newModel = '']) {
    if (newModel != '') setState(() => model = newModel);

    get(Uri.parse(url + '/api/${model}/${model}/'), 
      headers: {
        'Authorization': 'Token ${token}'
      }
    )
    .then((response) => setState(() {
      data = jsonDecode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
    }));
  }

  void postData() {
    setState(() => fields['utilisateur'] = {'username': username});

    post(Uri.parse(url + '/api/${model}/${model}/'),
      headers: {
        'Authorization': 'Token ${token}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(fields)
    )
    .then((response) {
      if (response.statusCode <= 201) {
        clearModal(withFields: true);

        getData();
      }
    });
  }

  void putData(int id) {
    setState(() => fields['utilisateur'] = {'username': username});

    put(Uri.parse(url + '/api/${model}/${model}/${id}/'),
      headers: {
        'Authorization': 'Token ${token}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(fields)    
    )
    .then((response) {
      if (response.statusCode == 200) {      
        clearModal(withFields: true);

        getData();
      }
    });
  }

  void deleteData(int id) {
    delete(Uri.parse(url + '/api/${model}/${model}/${id}/'), 
      headers: {
        'Authorization': 'Token ${token}'
      }    
    ).then((response) {
      if (response.statusCode <= 204) {
        clearModal();

        getData();
      }
    });
  }

  DataTable showData(BoxConstraints constraints) {
    Iterable<DataColumn> columns = [const DataColumn(label: Text(''))];
    Iterable<DataRow> rows = [];

    Color handleCellColor(dynamic info) {
      if (model != 'documents') return Colors_.primaryLightFont;

      switch (info.toString().toLowerCase()) {
        case 'en cours':
          return Colors_.accent;
        
        case 'terrain':
          return Colors_.warning;

        case 'bureau':
          return Colors_.warning;

        case 'instance':
          return Colors_.danger;

        case 'complet':
          return Colors_.success;

        case 'cadastre':
          return Colors_.info;
        
        case 'scanner':
          return const Color(0xFF000000);

        default:
          return Colors_.primaryLightFont;
      }
    }

    DataColumn generateColumn(String? info) {
      return DataColumn(
        label: Text(info.toString(),
          style: TextStyle(
            color: Colors_.primaryLightFont,
            fontWeight: FontWeight.w500,
            fontSize: constraints.maxWidth > 420.0 ? 16.0 : 14.0 
          )
        )
      );
    }

    DataCell generateCell(dynamic info) {
      if (info is Null) info = '';
      return DataCell(
        Text(
          info.toString(),
          style: TextStyle(
            color: handleCellColor(info),
            fontWeight: FontWeight.w400,
            fontSize: constraints.maxWidth > 420.0 ? 15.0 : 13.0
          )
        ),
      );
    }

    switch (model) {
      case 'clients':
        columns = [
          generateColumn('ID'),
          generateColumn('Utilisateur'),
          generateColumn('Numéro du document'),
          generateColumn('Propriété dite'),
          generateColumn('Titre foncière'),
          generateColumn('Nature'),
          generateColumn('Cadastre'),
          generateColumn('Nom'),
          generateColumn('Téléphone'),
          generateColumn('Réf propriétaire 1'),
          generateColumn('Réf propriétaire 2'),
          generateColumn('Ajouté le'),
          generateColumn('Modifié le'),
          generateColumn('Modifier'),
          generateColumn('Supprimer'),
        ];
        rows = data.map((object) {
          return DataRow(
            cells: [
              generateCell(object['id']),
              generateCell(capitalize(object['utilisateur']?['username'])),
              generateCell(object['numero_du_document']?['id']),
              generateCell(object['propriete_dite'].toString().toUpperCase()),
              generateCell(object['titre_fonciere']),
              generateCell(capitalize(object['nature'])),
              generateCell(object['cadastre']?['nom'].toString().toUpperCase()),
              generateCell(object['nom'].toString().toUpperCase()),
              generateCell(formatPhone(object['telephone'])),
              generateCell(object['ref_proprietaire_1']),
              generateCell(object['ref_proprietaire_2']),
              generateCell(formatDateTime(object['ajoute_le'])),
              generateCell(formatDateTime(object['modifie_le'])),
              DataCell(
                Button(
                  title: '',
                  onTap: () {
                    handleField(object['utilisateur']?['username'], 'utilisateur');
                    handleField(object['numero_du_document']?['id'], 'numero_du_document');
                    handleField(object['propriete_dite'], 'propriete_dite');
                    handleField(object['titre_fonciere'], 'titre_fonciere');
                    handleField(object['nature'], 'nature');
                    handleField(object['cadastre']?['nom'], 'cadastre');
                    handleField(object['nom'], 'nom');
                    handleField(object['telephone'], 'telephone');
                    handleField(object['ref_proprietaire_1'], 'ref_proprietaire_1');
                    handleField(object['ref_proprietaire_2'], 'ref_proprietaire_2');

                    requestPutData(object['id'], constraints);
                  },
                  icon: Icons.edit,
                  iconColor: Colors_.warning
                )
              ),
              DataCell(
                Button(
                  title: '',
                  onTap: () => requestDeleteData(object['id']),
                  icon: Icons.clear,
                  iconColor: Colors_.danger
                )
              )       
            ]
          );
        });
        break;

      case 'documents':
        columns = [
          generateColumn('ID'),
          generateColumn('Utilisateur'),
          generateColumn('État'),
          generateColumn('Agent de terrain'),
          generateColumn('Agent de bureau'),
          generateColumn("Date d'envoie"),
          generateColumn('Date de récépissé'),
          generateColumn('Ajouté le'),
          generateColumn('Modifié le'),
          generateColumn('Modifier'),
          generateColumn('Supprimer'),
        ];
        rows = data.map((object) {
          return DataRow(
            cells: [
              generateCell(object['id']),
              generateCell(capitalize(object['utilisateur']?['username'])),
              generateCell(capitalize(object['etat'])),
              generateCell(capitalize(object['agent_de_terrain']?['username'])),
              generateCell(capitalize(object['agent_de_bureau']?['username'])),
              generateCell(formatDate(object['date_de_envoie'])),
              generateCell(formatDate(object['date_de_recepisse'])),
              generateCell(formatDateTime(object['ajoute_le'])),
              generateCell(formatDateTime(object['modifie_le'])),
              DataCell(
                Button(
                  title: '',
                  onTap: () {
                    handleField(object['utilisateur']?['username'], 'utilisateur');
                    handleField(object['etat'], 'etat');
                    handleField(object['agent_de_terrain']?['username'], 'agent_de_terrain');
                    handleField(object['agent_de_bureau']?['username'], 'agent_de_bureau');
                    handleField(object['date_de_envoie'], 'date_de_envoie');
                    handleField(object['date_de_recepisse'], 'date_de_recepisse');

                    requestPutData(object['id'], constraints);
                  },
                  icon: Icons.edit,
                  iconColor: Colors_.warning
                )
              ),
              DataCell(
                Button(
                  title: '',
                  onTap: () => requestDeleteData(object['id']),
                  icon: Icons.clear,
                  iconColor: Colors_.danger
                )
              )
            ]
          );
        });
        break;

      case 'financement':
        columns = [
          generateColumn('ID'),
          generateColumn('Utilisateur'),
          generateColumn('Client'),
          generateColumn('Avance 1'),
          generateColumn("Date d'avance 1"),
          generateColumn('Avance 2'),
          generateColumn("Date d'avance 2"),
          generateColumn('Reste'),
          generateColumn('Mode'),
          generateColumn('Ajouté le'),
          generateColumn('Modifié le'),
          generateColumn('Modifier'),
          generateColumn('Supprimer')
        ];
        rows = data.map((object) {
          return DataRow(
            cells: [
              generateCell(object['id']),
              generateCell(capitalize(object['utilisateur']?['username'])),
              generateCell(object['client']?['id']),
              generateCell(object['avance_1']),
              generateCell(formatDate(object['date_de_avance_1'])),
              generateCell(object['avance_2']),
              generateCell(formatDate(object['date_de_avance_2'])),
              generateCell(object['reste']),
              generateCell(object['mode'].toString().toUpperCase()),
              generateCell(formatDateTime(object['ajoute_le'])),
              generateCell(formatDateTime(object['modifie_le'])),
              DataCell(
                Button(
                  title: '',
                  onTap: () {
                    handleField(object['utilisateur']?['username'], 'utilisateur');
                    handleField(object['client']?['id'], 'client');
                    handleField(object['avance_1'], 'avance_1');
                    handleField(object['date_de_avance_1'], 'date_de_avance_1');
                    handleField(object['avance_2'], 'avance_2');
                    handleField(object['date_de_avance_2'], 'date_de_avance_2');
                    handleField(object['reste'], 'reste');
                    handleField(object['mode'], 'mode');

                    requestPutData(object['id'], constraints);
                  },
                  icon: Icons.edit,
                  iconColor: Colors_.warning
                )
              ),
              DataCell(
                Button(
                  title: '',
                  onTap: () => requestDeleteData(object['id']),
                  icon: Icons.clear,
                  iconColor: Colors_.danger
                )
              )
            ]
          );
        });
        break;
    }
    return DataTable(
      columns: columns.toList(),
      rows: rows.toList()
    );
  }

  Iterable<Map<String, dynamic>> generateModalFields() {
    switch (model) {
      case 'clients':
        return [
          {
            'label': 'Numéro du document:',
            'name': 'numero_du_document',
            'keyboardType': TextInputType.number,
            'hintText': 'Le numéro du document',
          },
          {
            'label': 'Propriété dite:',
            'name': 'propriete_dite',
            'keyboardType': TextInputType.text,
            'hintText': 'La propriété dite',
          },
          {
            'label': 'Titre foncière:',
            'name': 'titre_fonciere',
            'keyboardType': TextInputType.text,
            'hintText': 'Le titre foncière',
          },
          {
            'label': 'Nature:',
            'name': 'nature',
            'keyboardType': TextInputType.name,
            'hintText': 'La nature',
          },
          {
            'label': 'Cadastre:',
            'name': 'cadastre',
            'keyboardType': TextInputType.name,
            'hintText': 'Le cadastre',
          },
          {
            'label': 'Nom:',
            'name': 'nom',
            'keyboardType': TextInputType.name,
            'hintText': 'Le nom',
          },
          {
            'label': 'Téléphone:',
            'name': 'telephone',
            'keyboardType': TextInputType.number,
            'hintText': 'Le téléphone',
          },
          {
            'label': 'Réf propriétaire 1:',
            'name': 'ref_proprietaire_1',
            'keyboardType': TextInputType.number,
            'hintText': 'La réf propriétaire 1',
          },
          {
            'label': 'Réf propriétaire 2:',
            'name': 'ref_proprietaire_2',
            'keyboardType': TextInputType.name,
            'hintText': 'La réf propriétaire 2',
          }
        ];

      case 'documents':
        return [
          {
            'label': 'État:',
            'name': 'etat',
            'keyboardType': TextInputType.name,
            'hintText': "L'état",
          },
          {
            'label': 'Agent de terrain:',
            'name': 'agent_de_terrain',
            'keyboardType': TextInputType.name,
            'hintText': "L'agent de terrain",
          },
          {
            'label': 'Agent de bureau:',
            'name': 'agent_de_bureau',
            'keyboardType': TextInputType.name,
            'hintText': "L'agent de bureau",
          },
          {
            'label': "Date d'envoie:",
            'name': 'date_de_envoie',
            'keyboardType': TextInputType.datetime,
            'hintText': "La date d'envoie",
          },
          {
            'label': 'Date de récépissé:',
            'name': 'date_de_recepisse',
            'keyboardType': TextInputType.datetime,
            'hintText': "La date de récépissé",
          }
        ];

      case 'financement':
        return [
          {
            'label': 'Client:',
            'name': 'client',
            'keyboardType': TextInputType.number,
            'hintText': "Le client",
          },
          {
            'label': 'Avance 1:',
            'name': 'avance_1',
            'keyboardType': TextInputType.number,
            'hintText': "L'avance 1",
          },
          {
            'label': "Date d'avance 1:",
            'name': 'date_de_avance_1',
            'keyboardType': TextInputType.datetime,
            'hintText': "La date d'avance 1",
          },
          {
            'label': 'Avance 2:',
            'name': 'avance_2',
            'keyboardType': TextInputType.number,
            'hintText': "L'avance 2",
          },
          {
            'label': "Date d'avance 2:",
            'name': 'date_de_avance_2',
            'keyboardType': TextInputType.datetime,
            'hintText': "La date d'avance 2",
          },
          {
            'label': 'Reste:',
            'name': 'reste',
            'keyboardType': TextInputType.number,
            'hintText': 'Le reste',
          },
          {
            'label': 'Mode:',
            'name': 'mode',
            'keyboardType': TextInputType.name,
            'hintText': 'Le mode',
          }
        ];

      default:
        return [];
    }
  }

  void clearModal({withFields = false}) {
    setState(() {
      modal['visibility'] = false;
      modal['functionality'] = () => null;
      modal['content'] = const SizedBox();

      if (withFields) fields.clear();
    });
  }

  void handleField(dynamic value, String name) {
    setState(() {
      if (value is String) value = capitalize(value);
    
      switch (name) {
        case 'numero_du_document':
          fields[name] = {'id': value};
          break;

        case 'cadastre':
          fields[name] = {'nom': value};
          break;

        case 'agent_de_terrain':
          fields[name] = {'username': value};
          break;

        case 'agent_de_bureau':
          fields[name] = {'username': value};
          break;

        case 'client':
          fields[name] = {'id': value};
          break;

        default:
          fields[name] = value;
          break;
      } 
    });
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Layout(
        top: true,
        right: true,
        bottom: true,
        left: true,
        child: Stack(
          children: [
            Column(
              children: [
                Header(
                  width: double.infinity,
                  height: 80.0,
                  color: Colors_.primaryLightBg,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  border: const Border(
                    bottom: BorderSide(
                      color: Colors_.primaryBorder
                    )
                  ),
                  children: [
                    Logo(
                      image: 'assets/images/logo.png',
                      padding: EdgeInsets.all(constraints.maxWidth > 420.0 ? 0 : 2.5),
                      width: 200.0,
                      height: 200.0
                    ),
                    constraints.maxWidth > 420.0 ? const Text('Topographe',
                      style: TextStyle(
                        color: Colors_.primaryLightFont,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500
                      )
                    ) : const SizedBox(),
                    UserBar(
                      username: capitalize(username.toString()),
                      icon: Icons.power_settings_new,
                      onTap: logout,
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      alignment: Alignment.center,
                      color: Colors_.primaryLightBg,
                      fontColor: Colors_.primaryLightFont,
                      fontWeight: FontWeight.w500,
                      fontSize: constraints.maxWidth > 420.0 ? 16.0 : 14.0,
                      space: 20.0,
                      iconColor: Colors_.primaryLightFont,
                      iconSize: 20.0,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SideBar(
                      color: Colors_.primaryLightBg,
                      radius: BorderRadius.circular(5.0),
                      width: constraints.maxWidth > 780.0 ? 200.0 : 60.0,
                      height: (
                        MediaQuery.of(context).size.height
                        - MediaQuery.of(context).padding.top
                        - MediaQuery.of(context).padding.bottom
                        - 60.0
                      ),
                      shadow: const [
                        Shadows.light
                      ],
                      children: [
                        SideBarChild(
                          onTap: () => getData('clients'),
                          icon: Icons.person,
                          title: constraints.maxWidth > 780.0 ? 'Clients' : '',
                          height: 60.0,
                          padding: EdgeInsets.all(constraints.maxWidth > 780.0 ? 20.0 : 5.0),
                          border: Border(
                            left: BorderSide(
                              color: Colors_.accent, 
                              width: model == 'clients' ? 3.0 : 0.0
                            )
                          ),
                          iconColor: model == 'clients' ? Colors_.accent : Colors_.primaryLightFont,
                          iconSize: 20.0,
                          fontColor: model == 'clients' ? Colors_.accent : Colors_.primaryLightFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0
                        ),
                        SideBarChild(
                          onTap: () => getData('documents'),
                          icon: Icons.folder,
                          title: constraints.maxWidth > 780.0 ? 'Dossiers' : '',
                          height: 60.0,
                          padding: EdgeInsets.all(constraints.maxWidth > 780.0 ? 20.0 : 5.0),
                          border: Border(
                            left: BorderSide(
                              color: Colors_.accent, 
                              width: model == 'documents' ? 3.0 : 0.0
                            )
                          ),
                          iconColor: model == 'documents' ? Colors_.accent : Colors_.primaryLightFont,
                          iconSize: 20.0,
                          fontColor: model == 'documents' ? Colors_.accent : Colors_.primaryLightFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0
                        ),
                        SideBarChild(
                          onTap: () => getData('financement'),
                          icon: Icons.payments,
                          title: constraints.maxWidth > 780.0 ? 'Financement' : '',
                          height: 60.0,
                          padding: EdgeInsets.all(constraints.maxWidth > 780.0 ? 20.0 : 5.0),
                          border: Border(
                            left: BorderSide(
                              color: Colors_.accent, 
                              width: model == 'financement' ? 3.0 : 0.0
                            )
                          ),
                          iconColor: model == 'financement' ? Colors_.accent : Colors_.primaryLightFont,
                          iconSize: 20.0,
                          fontColor: model == 'financement' ? Colors_.accent : Colors_.primaryLightFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0
                        )
                      ]
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: (
                              MediaQuery.of(context).size.height
                              - MediaQuery.of(context).padding.top
                              - MediaQuery.of(context).padding.bottom
                              - 60.0
                              - (constraints.maxWidth > 780.0 ? 100.0 : 40.0)
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth > 780.0 ? 40.0 : 10.0, 
                              vertical: constraints.maxWidth > 780.0 ? 30.0 : 5.0
                            ),
                            margin: EdgeInsets.all(constraints.maxWidth > 780.0 ? 50.0 : 20.0),
                            decoration: BoxDecoration(
                              color: Colors_.primaryLightBg,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                Shadows.light
                              ]
                            ),
                            child: Scrollbar(
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context).copyWith(
                                  dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse
                                  } 
                                ),
                                child: SingleChildScrollView(
                                  controller: ScrollController(),
                                  scrollDirection: Axis.horizontal,
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      child: showData(constraints)
                                    ),
                                  )
                                ),
                              )
                            )
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Button(
                              title: '',
                              onTap: () => requestPostData(constraints),
                              width: constraints.maxWidth > 780.0 ? 50.0 : (constraints.maxWidth > 420.0 ? 40.0 : 30.0),
                              height: constraints.maxWidth > 780.0 ? 50.0 : (constraints.maxWidth > 420.0 ? 40.0 : 30.0),
                              color: Colors_.successBg,
                              margin: EdgeInsets.all(constraints.maxWidth > 780.0 ? 25.0 : 10.0),
                              shadow: const [
                                Shadows.light
                              ],
                              icon: Icons.add,
                              iconColor: Colors_.quaternaryDarkFont,
                              iconSize: constraints.maxWidth > 780.0 ? 25.0 : (constraints.maxWidth > 420.0 ? 20.0 : 15.0),
                              shape: BoxShape.circle
                            ),
                          )
                        ]
                      ),
                    )
                  ]
                ), 
                Footer(
                  width: double.infinity,
                  height: constraints.maxWidth > 420.0 ? 50.0 : 40.0,
                  alignment: Alignment.center,
                  color: Colors_.primaryLightBg,
                  shadow: const [
                    Shadows.light
                  ],
                  child: Text('Developed by Salim Mghari',
                    style: TextStyle(
                      color: Colors_.primaryLightFont,
                      fontWeight: FontWeight.w500,
                      fontSize: constraints.maxWidth > 420.0 ? 13.0 : 11.0
                    )
                  )
                )
              ],
            ),
            Modal(
              alignment: Alignment.center,
              headerFlex: 2,
              title: modal['title'],
              onClose: () => clearModal(),
              titleAlignment: Alignment.center,
              flex: 6,
              child: modal['content'],
              footerFlex: 2,
              confirmAlignment: Alignment.center,
              confirmTitle: 'Confirmer',
              onTap: modal['functionality'],
              width: modal['visibility'] == true ? (constraints.maxWidth > 420.0 ? 600.0 : 300.0) : 0.001,
              height: modal['height'],
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth > 420.0 ? 30.0 : 20.0, 
                vertical: constraints.maxWidth > 420.0 ? 20.0 : 10.0
              ),
              margin: const EdgeInsets.only(
                top: 75.0
              ),
              radius: BorderRadius.circular(5.0),
              color: Colors_.primaryLightBg,
              shadow: modal['visibility'] == true ? [Shadows.light] : [],
              closeTopPosition: 0,
              closeRightPosition: 0,
              closeIcon: Icons.clear,
              closeIconColor: Colors_.danger,
              closeIconSize: 25.0,
              titleSize: 18.0,
              titleWeight: FontWeight.w500,
              titleColor: Colors_.primaryLightFont,
              confirmWidth: 180.0,
              confirmHeight: 40.0,
              confirmColor: Colors_.accent,
              confirmRadius: BorderRadius.circular(5.0),
              confirmShadow: modal['visibility'] == true ? [Shadows.light] : [],
              confirmTitleSize: 15.0,
              confirmTitleColor: Colors_.quaternaryLightFont,
              confirmTitleWeight: FontWeight.w500,
              confirmPadding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0
              ),
              space: 20.0
            )
          ],
        )
      ),
    );
  }
}
