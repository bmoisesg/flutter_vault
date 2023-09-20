import 'package:flutter/material.dart';
import 'package:flutter_gestor_contras/bloc/bloc.dart';

class MyInheriteWidget extends InheritedWidget {
  final Widget child;
  final vaultBloc loginBloc;

  const MyInheriteWidget({
    required this.child,
    required this.loginBloc,
    super.key,
  }) : super(child: child);

  static MyInheriteWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
