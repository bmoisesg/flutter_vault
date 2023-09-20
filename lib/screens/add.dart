// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_gestor_contras/widgets/custom_btn.dart';

class AddPass extends StatefulWidget {
  const AddPass({super.key});

  @override
  State<AddPass> createState() => _AddPassState();
}

class _AddPassState extends State<AddPass> {
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
    TextEditingController ctrlSiteAddress = TextEditingController();
    TextEditingController ctrlUserName = TextEditingController();
    TextEditingController ctrlPass = TextEditingController();
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
              TextFormField(
                keyboardType: TextInputType.text,
                controller: ctrlSiteAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.language),
                  border: OutlineInputBorder(),
                  labelText: "",
                  fillColor: Colors.transparent,
                  filled: true,
                  isDense: true,
                ),
              ),
              separador,
              const Text(
                'User Name',
                style: TextStyle(color: Color(0xff757784)),
              ),
              separador,
              TextFormField(
                keyboardType: TextInputType.text,
                controller: ctrlUserName,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                  labelText: "",
                  fillColor: Colors.transparent,
                  filled: true,
                  isDense: true,
                ),
              ),
              separador,
              const Text(
                'Password',
                style: TextStyle(color: Color(0xff757784)),
              ),
              separador,
              TextFormField(
                keyboardType: TextInputType.text,
                controller: ctrlPass,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_open),
                  border: OutlineInputBorder(),
                  labelText: "",
                  fillColor: Colors.transparent,
                  filled: true,
                  isDense: true,
                ),
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
        CustomBtn(myTitle: 'Create the voult', myFuntion: fntCreate),
        const SizedBox(height: 20),
      ],
    );
  }

  fntCreate() {
    print('Creando la encuesta...');
  }
}
