import 'package:flutter/material.dart';
import 'package:to_do_app/model/category_model.dart';
import 'package:to_do_app/screen/home_screen.dart';
import 'package:to_do_app/services/category_services.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _categoryList = List<Category>.empty(growable: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await _categoryServices.readCategories();
    if (categories != null) {
      categories.forEach((category) {
        setState(() {
          var categoryModel = Category();
          categoryModel.name = category["name"];
          categoryModel.description = category["description"];
          categoryModel.id = category["id"];
          _categoryList.add(categoryModel);
        });
      });
    }
  }

  var _categoryNameController = TextEditingController();
  var _categorydescriptionController = TextEditingController();

  var _editcategoryNameController = TextEditingController();
  var _editcategorydescriptionController = TextEditingController();

  var _category = Category();
  var _categoryServices = CategoryService();

  _showFromDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              MaterialButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
              MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    var category;
                    _category.id = category[0]["id"];

                    _category.name = _categoryNameController.text;
                    _category.description = _categorydescriptionController.text;
                    var result =
                        await _categoryServices.saveCategory(_category);
                    if (result > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => CategoriesScreen()),
                          (Route<dynamic> route) => false);
                    }
                  },
                  child: Text("Save")),
            ],
            title: Text("Caegories Form"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Write a Category",
                      labelText: "Write a category",
                    ),
                    controller: _categoryNameController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Write description",
                      labelText: "description",
                    ),
                    controller: _categorydescriptionController,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editFromDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              MaterialButton(
                color: Colors.red,
                child: Text("Cancel"),
                onPressed: () => {Navigator.of(context).pop},
              ),
              MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    var category;
                    _category.id = category[0]["id"];
                    _category.name = _editcategoryNameController.text;
                    _category.description =
                        _editcategorydescriptionController.text;
                    var result =
                        await _categoryServices.updateCategory(_category);
                    if (result > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => CategoriesScreen()),
                          (Route<dynamic> route) => false);
                    }
                  },
                  child: Text("Save")),
            ],
            title: Text("Caegories Form"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Write a Category",
                      labelText: "Write a category",
                    ),
                    controller: _categorydescriptionController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Write description",
                      labelText: "description",
                    ),
                    controller: _categorydescriptionController,
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editCategory(BuildContext context, categoryId) async {
    var category = await _categoryServices.readCategoryById(categoryId);
    setState(() {
      _editcategoryNameController.text = category[0]["name"] ?? "No Name";
      _editcategoryNameController.text =
          category[0]["description"] ?? "No description";
    });
    _editFromDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text("Categories"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          color: Colors.cyan,
          elevation: 2,
          child: ListTile(
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
        /*
          itemCount: _categoryList.length,
          itemBuilder: (contet, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Card(
                elevation: 8,
                child: ListTile(
                  leading: IconButton(
                      onPressed: () {
                        _editCategory(context, _categoryList[index].id);
                      },
                      icon: Icon(Icons.edit)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_categoryList[index].name.toString()),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ),
                ),
              ),
            );
          }*/
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFromDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
