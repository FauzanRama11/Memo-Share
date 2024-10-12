import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/provider/userProvider.dart';
import 'package:provider/provider.dart';
import '../model/event.dart';
import '../provider/eventProvider.dart';
import '../utilities/event-list.dart';
import '../utilities/homeAppBar.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
  final List<DateTime> toHighlight = [];
  final Map<String, List<dynamic>> marks = {};
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  TimeOfDay timeSelected = TimeOfDay.now();
  DateTime dateSelected = DateTime.now();
  int index = 0;
  String? currentDate = DateFormat.yMd().format(DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<EventList>(context, listen: false).initEvent();
    widget.toHighlight.clear();
    widget.marks.clear();
    initEventlist();
    super.didChangeDependencies();
  }

  void initEventlist() {
    var events =
        Provider.of<EventList>(context, listen: true).events.values.toList();
    var dateKey;

    for (Event event in events) {
      dateKey = DateFormat.yMd().format(event.date);
      if (!widget.toHighlight.contains(dateKey)) {
        widget.marks[dateKey] = [...?widget.marks[dateKey], event];
      }
    }
  }

  // addNewtask() {
  //   return showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(
  //               'Tambahkan Tugas',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 20,
  //                 fontFamily: 'Nunito',
  //                 color: Color(0xFF2585DE),
  //               ),
  //             ),
  //             const SizedBox(height: 35),

  //             // Input Activity
  //             TextField(
  //               controller: titleController,
  //               decoration: InputDecoration(
  //                   border: OutlineInputBorder(),
  //                   labelText: 'Kegiatan',
  //                   fillColor: Color(0xFF2585DE)),
  //             ),
  //             const SizedBox(height: 15),

  //             // Input Keterangan Tambahan
  //             TextField(
  //               controller: subtitleController,
  //               decoration: InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 labelText: 'Keterangan',
  //               ),
  //             ),
  //             const SizedBox(height: 15),

  //             // Input Tanggal
  //             MaterialButton(
  //               minWidth: double.infinity,
  //               height: 50,
  //               onPressed: pickDate,
  //               color: Color(0xFF2585DE),
  //               child: const Text(
  //                 'Pilih tanggal',
  //                 // textAlign: TextAlign.left,
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.normal,
  //                   fontSize: 15,
  //                   fontFamily: 'Nunito',
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 15),

  //             // Input Jam
  //             MaterialButton(
  //               minWidth: double.infinity,
  //               elevation: 3,
  //               height: 50,
  //               onPressed: pickTime,
  //               color: Color(0xFF2585DE),
  //               child: const Text(
  //                 'Pilih jam',
  //                 // textAlign: TextAlign.left,
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.normal,
  //                   fontSize: 15,
  //                   fontFamily: 'Nunito',
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 25),

  //             // Tombol save & cancel
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 MaterialButton(
  //                   minWidth: 102,
  //                   height: 40,
  //                   onPressed: () async {
  //                     final user = await AuthMethods().getUserDetails();
  //                     Provider.of<ListProvider>(context, listen: false).addList(
  //                       ToDo(
  //                         uid: user.uid,
  //                         toDoAct: titleController.text,
  //                         toDoNote: subtitleController.text,
  //                         toDoTime: timeSelected.format(context).toString(),
  //                         toDoDate: dateSelected,
  //                         isDone: false,
  //                       ),
  //                     );
  //                     // titleController.clear();
  //                     // subtitleController.clear();
  //                     Navigator.pop(context);
  //                   },
  //                   color: Color(0xFF2585DE),
  //                   child: const Text(
  //                     'Simpan',
  //                     style: TextStyle(
  //                         fontFamily: 'Nunito',
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.white,
  //                         fontSize: 15),
  //                   ),
  //                 ),
  //                 MaterialButton(
  //                   minWidth: 102,
  //                   height: 40,
  //                   onPressed: () => Navigator.of(context).pop(),
  //                   color: Color(0xFF2585DE),
  //                   child: const Text(
  //                     'Kembali',
  //                     style: TextStyle(
  //                         fontFamily: 'Nunito',
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.white,
  //                         fontSize: 15),
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Pick the Date
  void pickDate() {
    showDatePicker(
      helpText: 'Pilih Tanggal',
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    ).then(
      (value) {
        setState(
          () {
            dateSelected = value!;
          },
        );
      },
    );
  }

  // Pick the Time
  void pickTime() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (value) {
        setState(
          () {
            timeSelected = value!;
          },
        );
      },
    );
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // Provider.of<ListProvider>(context, listen: false).getList();
  //   // print('object');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(185), child: HomeAppBar()),
      // floatingActionButton: FloatingActionButton(
      //   // Adding task
      //   onPressed: () => addNewtask(),
      //   child: Icon(Icons.post_add_rounded),
      // ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(20),
            child: Text(
              "Tugas Anda",
              style: TextStyle(
                color: Color(0xFF6C9BC8),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Nunito',
              ),
            ),
          ),
          Flexible(
            child: widget.marks[currentDate] == null
                ? Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Tidak ada event untuk hari ini: ',
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ],
                  )
                // : ListView.builder(
                //     itemCount: widget.marks[currentDate]!.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Column(
                //         children: [
                //           EventListTile(
                //             event: widget.marks[currentDate]![index],
                //           ),
                //           const SizedBox(
                //             height: 10,
                //           ),
                //         ],
                //       );
                //     },
                //   ))

                // Expanded(
                //   child
                : Consumer<EventList>(builder: (context, event, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          (event.events.isEmpty || event.events.length < 3)
                              ? event.events.length
                              : 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            EventListTile(
                                event: event.events.values.toList()[index],
                                deleteButton: (BuildContext) {}),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      },
                    );
                  }),
          )
        ],
      ),
    );
  }
}
