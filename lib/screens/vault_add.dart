// ignore_for_file: avoid_print

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
    ctrlSiteAddress.text = "http://facebook.com";
    ctrlPass.text = "123";
    ctrlUserName.text = "mi contraseña";
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
            child: ListView(children: [_buildBody()]),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    var separador = const SizedBox(height: 10);
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
          myFuntion: fntCreateVault,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  fntCreateVault() {
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
    ));
    /*  ctrlPass.text = "";
    ctrlSiteAddress.text = "";
    ctrlUserName.text = ""; */
  }
}
