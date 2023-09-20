// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_gestor_contras/color.dart';
import 'package:flutter_gestor_contras/utils/autentication.dart';
import 'package:flutter_gestor_contras/widgets/custom_btn.dart';
import 'package:flutter_gestor_contras/widgets/custom_input.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController ctrlUserName = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      /* ctrlUserName.text = "bmoisesg@gmail.com";
      ctrlPass.text = "admin123"; */
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColor.grey,
        title: const Text(
          'Create Account',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: MyColor.grey,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              separador,
              const Text(
                'Email',
                style: TextStyle(color: Color(0xff757784)),
              ),
              separador,
              CustomInput(
                myCtl: ctrlUserName,
                myIcon: const Icon(Icons.person_outline),
                typeInput: TextInputType.emailAddress,
              ),
              separador,
              const Text(
                'password',
                style: TextStyle(color: Color(0xff757784)),
              ),
              separador,
              CustomInput(
                myCtl: ctrlPass,
                myIcon: const Icon(Icons.lock_open),
                hidePass: true,
              ),
              const SizedBox(height: 20),
              CustomBtn(
                myTitle: 'Create Account',
                myFuntion: fntCreateAccount,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  fntCreateAccount() async {
    if (ctrlPass.text == "" || ctrlUserName.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Not is valid value empy')));
      return;
    }

    await Authentication().signUp(
      ctrlUserName.text.trim(),
      ctrlPass.text.trim(),
      context,
    );

    ctrlPass.text = "";
  }
}
