import 'package:flutter/material.dart';
//import 'package:flutter_application_1/to-do use/todo.dart';

class AddTaskBox extends StatefulWidget {
  AddTaskBox({
    super.key,
  });

  @override
  State<AddTaskBox> createState() => _AddTaskBoxState();
}

class _AddTaskBoxState extends State<AddTaskBox> {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final trailingController = TextEditingController();
  final List<ListTile> items = [];

  // @override
  // void dispose() {
  //   titleController.dispose();
  //   subtitleController.dispose();
  //   trailingController.dispose();
  //   super.dispose();
  // }

  void addItemToList() {
    setState(() {
      items.add(ListTile(
        title: Text(titleController.text,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
        subtitle: Text(
          subtitleController.text,
          style: TextStyle(
            color: Color(0xFF8C8C8C),
            fontFamily: 'Nunito',
          ),
        ),
        trailing: Text(
          trailingController.text,
          style: TextStyle(
            color: Color(0xFF8C8C8C),
            fontFamily: 'Nunito',
          ),
        ),
      ));
      titleController.clear();
      subtitleController.clear();
      trailingController.clear();
    });
  }

  // void addToDoItem() {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tambahkan Tugas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Nunito',
              color: Color(0xFF2585DE),
            ),
          ),
          SizedBox(height: 35),

          // Input Activity
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Kegiatan',
                fillColor: Color(0xFF2585DE)),
          ),
          SizedBox(height: 15),

          // Input Keterangan Tambahan
          TextField(
            controller: subtitleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Keterangan',
            ),
          ),
          SizedBox(height: 15),

          // Input Waktu
          TextField(
            controller: trailingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Jam',
            ),
          ),
          SizedBox(height: 20),

          // Tombol save
          SizedBox(
            width: double.infinity,
            child: FloatingActionButton(
                onPressed: addItemToList,
                mini: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Simpan',
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}
