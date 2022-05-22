import 'package:flutter/material.dart';

import '../helpers/db_helpers.dart';
import '../model/helper_model.dart';

class CreateToDo extends StatefulWidget {
  final Note? note;
  const CreateToDo({Key? key, this.note}) : super(key: key);

  @override
  State<CreateToDo> createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  final _formKey = GlobalKey<FormState>();

  late String txtBaslik;
  late String txtAciklama;
  late String txtTarih;

  @override
  void initState() {
    super.initState();

    txtBaslik = widget.note?.baslik ?? '';
    txtAciklama = widget.note?.aciklama ?? '';

    //txtBaslik = TextEditingController() as String;
    //txtAciklama = TextEditingController() as String;
    //txtTarih = TextEditingController() as String;
  }

/*  var dbHelper = DbHelper();
  var txtBaslik;
  var txtAciklama;
  var txtTarih;

  @override
  void initState() {
    super.initState();

    txtBaslik = TextEditingController();
    txtAciklama = TextEditingController();
    txtTarih = TextEditingController();
  }
*/
  DateTime? _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            _buildTextBaslik(),
            _buildTextAciklama(),
            Text(_dateTime != null
                ? "${_dateTime?.year}-${_dateTime?.month}-${_dateTime?.day}"
                : "Select Time"),
            ElevatedButton(
              child: Text('Pick a date'),
              onPressed: () async {
                DateTime? _newDate = await showDatePicker(
                  context: context,
                  initialDate: _dateTime!,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025),
                );

                if (_newDate != null) {
                  setState(() {
                    txtTarih = _newDate as String;
                    _dateTime = _newDate;
                  });
                }

                /* 
                showDatePicker(
                        context: context,
                        initialDate: _dateTime ?? DateTime.now(),
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2022))
                    .then((date) {
                  setState(() {
                    _dateTime = date;
                  });
                });*/
              },
            ),
            PopupMenuButton(
                icon: Icon(Icons.category),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      const PopupMenuItem(
                        child: Text('Option1'),
                      ),
                      const PopupMenuItem(
                        child: Text('Option2'),
                      ),
                      const PopupMenuItem(
                        child: Text('Option3'),
                      ),
                    ]),
            SizedBox(height: 17),
            _buildSaveBtn()
          ],
        ),
      ),
    );
  }

  FlatButton _buildSaveBtn() => FlatButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Row(
        children: [Text("Kaydet"), Icon(Icons.save)],
      ));

  _addProduct() async {
    final note = Note(baslik: txtBaslik, aciklama: txtAciklama);

    await DbHelper.instance.create(note);

    Navigator.of(context).pop();
    /*Note note;
    await DbHelper.instance.create(note);
    var response = await DbHelper.insert(
      Note(
        baslik: txtBaslik,
        aciklama: txtBaslik,
        //tarih: _dateTime.timeZoneName,
      ),
    );*/
    //return note;
  }

  TextField _buildTextAciklama() {
    return TextField(
      decoration: InputDecoration(labelText: "Description"),
      // controller: txtAciklama,
    );
  }

  TextField _buildTextBaslik() {
    return TextField(
      decoration: InputDecoration(labelText: "Title"),
      // controller: txtBaslik,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Create ToDo"),
    );
  }
}
