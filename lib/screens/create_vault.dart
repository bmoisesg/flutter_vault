// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gestor_contras/bloc/inheritedwidget.dart';
import 'package:flutter_gestor_contras/logic/vault.dart';
import 'package:flutter_gestor_contras/widgets/custom_btn.dart';
import 'package:flutter_gestor_contras/widgets/custom_input.dart';

class AddPassPage extends StatefulWidget {
  const AddPassPage({super.key});

  @override
  State<AddPassPage> createState() => _AddPassPageState();
}

class _AddPassPageState extends State<AddPassPage> {
  TextEditingController ctrlSiteAddress = TextEditingController();
  TextEditingController ctrlUserName = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<List<String>> getData() async {
    List<String> listCategory = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = await ref.child('categorias/').get();
    if (snapshot.exists) {
      if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> dataMap = snapshot.value as Map;
        dataMap.forEach((key, value) {
          listCategory.add(value['nameCategory']);
        });
        return listCategory;
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xfff0ecf2),
        title: const Text(
          'Create New Vaults',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: const Color(0xfff0edf2),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.95,
            child: ListView(children: [
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return _buildBody(snapshot.data!);
                  } else {
                    return Container();
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(List<String> list) {
    var separador = const SizedBox(height: 10);
    String selectedOption = list.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              separador,
              const Text(
                'Credential',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              separador,
              const Text(
                'Category',
                style: TextStyle(color: Color(0xff757784)),
              ),
              separador,
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff6b5e5d)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButton<String>(
                    isDense: true,
                    isExpanded: true,
                    underline: Container(),
                    value: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                );
              }),
              separador,
              const Text(
                'Site Address',
                style: TextStyle(color: Color(0xff757784)),
              ),
              separador,
              CustomInput(
                myCtl: ctrlSiteAddress,
                myIcon: const Icon(Icons.language),
              ),
              separador,
              const Text(
                'User Name',
                style: TextStyle(color: Color(0xff757784)),
              ),
              separador,
              CustomInput(
                myCtl: ctrlUserName,
                myIcon: const Icon(Icons.person_outline),
              ),
              separador,
              const Text(
                'Password',
                style: TextStyle(color: Color(0xff757784)),
              ),
              separador,
              CustomInput(
                myCtl: ctrlPass,
                myIcon: const Icon(Icons.lock_open),
                hidePass: true,
              ),
              separador,
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Add Tags',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('Here for tags'),
              SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CustomBtn(
          myTitle: 'Create the voult',
          myFuntion: () => fntCreateVault(selectedOption),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  fntCreateVault(String myCategory) {
    if (ctrlPass.text == "" ||
        ctrlSiteAddress.text == "" ||
        ctrlUserName.text == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Ingress all fields')));
      return;
    }
    var bloc = MyInheriteWidget.of(context)!.loginBloc;
    bloc.onEventAdd(Vault(
        contra: ctrlPass.text,
        dominio: ctrlSiteAddress.text,
        nombre: ctrlUserName.text,
        category: myCategory));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Saved!')));
    //Navigator.pop(context);
    ctrlPass.text = "";
    ctrlSiteAddress.text = "";
    ctrlUserName.text = "";
  }
}
