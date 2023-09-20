import 'package:flutter/material.dart';
import 'package:flutter_gestor_contras/logic/vault.dart';

class vaultBloc extends ChangeNotifier {
  List<Vault> listVaults = [];

  void onEventAdd(Vault newVault) {
    listVaults.add(newVault);
    notifyListeners();
  }

  void onEventDelete(int position) {
    listVaults.removeAt(position);
    notifyListeners();
  }

  void onEventFavVault(int index) {
    Vault vaultUpdate = listVaults[index];
    vaultUpdate.fav = !vaultUpdate.fav;
    listVaults[index] = vaultUpdate;
    notifyListeners();
  }

  void onEventDropList() {
    listVaults.clear();
    notifyListeners();
  }
}
