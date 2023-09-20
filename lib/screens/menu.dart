import 'package:flutter/material.dart';
import 'package:flutter_gestor_contras/bloc/inheritedwidget.dart';
import 'package:flutter_gestor_contras/screens/create_categories.dart';
import 'package:flutter_gestor_contras/screens/login.dart';
import 'package:flutter_gestor_contras/utils/autentication.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(38),
      children: [
        const FittedBox(
          child: Text('Name of the user'),
        ),
        const Divider(),
        ListTile(
          title: const Text('Categories'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoryPage()),
            );
          },
        ),
        const SizedBox(height: 10),
        ListTile(
          trailing: const Icon(Icons.exit_to_app),
          title: const Text('Log out'),
          onTap: () {
            var bloc = MyInheriteWidget.of(context)!.loginBloc;
            bloc.onEventDropList();
            Authentication().gmailSignOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ],
    );
  }
}
