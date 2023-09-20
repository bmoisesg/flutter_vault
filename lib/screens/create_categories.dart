import 'package:flutter/material.dart';
import 'package:flutter_gestor_contras/color.dart';
import 'package:flutter_gestor_contras/widgets/custom_btn.dart';
import 'package:flutter_gestor_contras/widgets/custom_input.dart';
import 'package:firebase_database/firebase_database.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

Future<dynamic> getData() async {
  List listaEcuestas = [];
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  DataSnapshot snapshot = await ref.child('categorias/').get();
  if (snapshot.exists) {
    if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> dataMap = snapshot.value as Map;
      dataMap.forEach((key, value) {
        listaEcuestas.add({"id": key, "nameCategory": value['nameCategory']});
      });
      return listaEcuestas;
    }
  }
  return [];
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController ctlCategory = TextEditingController();
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
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                color: MyColor.grey,
                child: Center(
                  child: FractionallySizedBox(
                      widthFactor: 0.9, child: _buildBody(snapshot.data!)),
                ));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildBody(List<dynamic> listCategory) {
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
                myCtl: ctlCategory,
                myIcon: const Icon(Icons.add),
                typeInput: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomBtn(
                myTitle: 'Create Category',
                myFuntion: fntCreate,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                const Text(
                  'Categories List Uploaded:',
                  style: TextStyle(color: Color(0xff757784)),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: listCategory.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                          listCategory[index]['nameCategory'].toString());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  fntCreate() async {
    if (ctlCategory.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Not valid, the value is empty')));
      return;
    }
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

    DatabaseReference ref = FirebaseDatabase.instance.ref();
    var data = {
      "nameCategory": ctlCategory.text,
    };
    await ref.child('categorias').push().set(data);
    Navigator.pop(context);

    setState(() {
      ctlCategory.text = "";
    });
  }
}
