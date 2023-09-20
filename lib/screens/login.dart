// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_gestor_contras/color.dart';
import 'package:flutter_gestor_contras/screens/create_account.dart';
import 'package:flutter_gestor_contras/screens/home.dart';
import 'package:flutter_gestor_contras/widgets/custom_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gestor_contras/utils/autentication.dart';
import 'package:flutter_gestor_contras/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController ctrlUserName = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();

  @override
  void initState() {
    super.initState();
    ctrlUserName.text = "bmoisesg@gmail.com";
    ctrlPass.text = "admin123";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColor.grey,
        title: const Text(
          'Vaults - melmv',
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
              CustomInput(
                  myCtl: ctrlUserName,
                  myIcon: const Icon(Icons.person_outline),
                  typeInput: TextInputType.emailAddress),
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
              const SizedBox(height: 20),
              CustomBtn(myTitle: 'LoginPage', myFuntion: fntLoginPage),
              const SizedBox(height: 20),
              TextButton(
                onPressed: fntCreateAccount,
                child: const Text('You do not have an account?'),
              ),
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
                'With Gmail',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              separador,
              CustomBtn(
                myTitle: 'Select account',
                myFuntion: fntLoginPageGmail,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  fntCreateAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateAccountPage()),
    );
  }

  fntLoginPage() async {
    if (ctrlPass.text == "" || ctrlUserName.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not is valid value empy')),
      );
      return;
    }

    User? user = await Authentication()
        .signIn(ctrlUserName.text, ctrlPass.text, context);

    if (user == null) {
      Authentication().signOut();
      return;
    }
    print(user);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  fntLoginPageGmail() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading...'),
            ],
          ),
        );
      },
    );
    User? user = await Authentication().gmailSignIn(context: context);
    print(user);
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
}
