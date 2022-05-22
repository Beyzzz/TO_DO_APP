import 'package:flutter/material.dart';
import 'package:to_do_app/helpers/draw_navigaton.dart';

import '../helpers/db_helpers.dart';
import '../model/helper_model.dart';
import 'crate_to_do.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> products;
  int productCount = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    DbHelper.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    products = (await DbHelper.instance.readAllNotes()).cast<Product>();

    setState(() => isLoading = false);
  }
  /*var dbHelper = DbHelper();
  late List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    var productFuture = dbHelper.getProducts();
    productFuture.then((value) {
      setState(() {
        products = value;
        productCount = value.length;
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todo List"),
        ),
        drawer: DrawerNavigation(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CreateToDo()));
          },
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => Card(
            color: Colors.cyan,
            elevation: 2,
            child: ListTile(
              trailing: Text("2022-05-21"),
              title: Text("Test"), //Text(products[index].toString()),
              subtitle:
                  Text("Text Description"), //Text(products[index].toString()),
              leading: CircleAvatar(
                  //backgroundColor: Colors.black12,
                  backgroundImage: NetworkImage(
                      'https://yt3.ggpht.com/a/AATXAJxRXmkWGv4_OxYgz3ILEKx06Gw4ez7MGkfrHw=s900-c-k-c0xffffffff-no-rj-mo')),
              onTap: () {
                //  goToDetail(products[index]);
              },
            ),
          ),
          itemCount: 1,
        )); /*ListView.builder(
          itemBuilder: (context, index) => Card(
            color: Colors.cyan,
            elevation: 2,
            child: ListTile(
              title: Text(products[index].toString()),
              subtitle: Text(products[index].toString()),
              leading: CircleAvatar(
                  //backgroundColor: Colors.black12,
                  backgroundImage: NetworkImage('https://yt3.ggpht.com/a/AATXAJxRXmkWGv4_OxYgz3ILEKx06Gw4ez7MGkfrHw=s900-c-k-c0xffffffff-no-rj-mo')),
              onTap: () {
                //  goToDetail(products[index]);
              },
            ),
          ),
          itemCount: products.length,
        ));*/
  }
}
