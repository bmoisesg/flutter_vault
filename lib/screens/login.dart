// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_gestor_contras/screens/create_account.dart';
import 'package:flutter_gestor_contras/widgets/custom_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_gestor_contras/utils/autentication.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController ctrlUserName = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xfff0ecf2),
        title: const Text(
          'Vaults - melmv',
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              separador,
              const Text(
                'With credentials',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              separador,
              separador,
              const Text(
                'Email',
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
                'password',
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
              const SizedBox(height: 20),
              CustomBtn(myTitle: 'Login', myFuntion: fntLogin),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: fntCreateAccount,
                  child: const Text('You do not have an account?')),
            ],
          ),
        ),
        const SizedBox(height: 10),
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
                'With Google',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              separador,
              CustomBtn(myTitle: 'Go', myFuntion: fntLoginGmail),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  fntLogin() {
    Authentication().signIn(ctrlUserName.text, ctrlPass.text);
  }

  fntCreateAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateAccountPage()),
    );
  }

  fntLoginGmail() async {}
}
