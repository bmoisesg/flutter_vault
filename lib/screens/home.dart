import 'package:flutter/material.dart';
import 'package:flutter_gestor_contras/bloc/inheritedwidget.dart';
import 'package:flutter_gestor_contras/color.dart';
import 'package:flutter_gestor_contras/screens/menu.dart';
import 'package:flutter_gestor_contras/screens/create_vault.dart';
import 'package:flutter_gestor_contras/widgets/custom_btn.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColor.grey,
        title: const Text('Home'),
      ),
      drawer: const Drawer(
        child: MenuPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fntAddVault,
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ), // Icono dentro del botón (puedes cambiarlo)
      ),
      body: Container(
        color: MyColor.grey,
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.95,
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    var bloc = MyInheriteWidget.of(context)!.loginBloc;
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, _) {
        return bloc.listVaults.isEmpty
            ? const Center(
                child: Text('Empty List'),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: bloc.listVaults.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person_outline),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    bloc.listVaults[index].nombre,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.language),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    bloc.listVaults[index].dominio,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.category),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    bloc.listVaults[index].category,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomBtn(
                              myTitle: 'Delete',
                              myFuntion: () {
                                bloc.onEventDelete(index);
                              },
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                bloc.onEventFavVault(index);
                              },
                              icon: Icon(
                                bloc.listVaults[index].fav
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: const Color(0xfff31e79),
                              )),
                        ),
                      ),
                    ],
                  );
                },
              );
      },
    );
  }

  fntAddVault() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddPassPage()),
    );
  }
}
