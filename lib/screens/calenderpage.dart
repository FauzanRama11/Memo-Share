import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/provider/eventProvider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../Resource/AuthMethod.dart';
import '../model/event.dart';

import '/model/user.dart' as model;
import '../provider/userProvider.dart';
import '../utilities/event-list.dart';
import '../utilities/publicAppBar.dart';

class CalenderPage extends StatefulWidget {
  CalenderPage({Key? key, required this.items});

  final List<ListTile> items;

  @override
  State<CalenderPage> createState() => _CalenderPage();
  final List<DateTime> toHighlight = [];
  final Map<String, List<dynamic>> marks = {};
}

class _CalenderPage extends State<CalenderPage> {
  String? currentDate = DateFormat.yMd().format(DateTime.now());
  DateTime today = DateTime.now();

  CalendarFormat format = CalendarFormat.month;
  TimeOfDay timeSelected = TimeOfDay.now();

  final titleController = TextEditingController();
  final subtitleController = TextEditingController();

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
        widget.toHighlight.add(event.date);
      }
    }
  }

  void printAll(List<dynamic>? lists) {
    if (lists == null) return;
    for (var list in lists) {
      print(list);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

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
            today = value!;
          },
        );
      },
    );
  }

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

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(95), child: PublicAppBar()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tambahkan Event',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Nunito',
                      color: Color(0xFF2585DE),
                    ),
                  ),
                  const SizedBox(height: 35),

                  // Input Activity
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Kegiatan',
                        fillColor: Color(0xFF2585DE)),
                  ),
                  const SizedBox(height: 15),

                  // Input Keterangan Tambahan
                  TextField(
                    controller: subtitleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Keterangan',
                    ),
                  ),
                  const SizedBox(height: 15),

                  // // Input Tanggal
                  // MaterialButton(
                  //   minWidth: double.infinity,
                  //   height: 50,
                  //   onPressed: pickDate,
                  //   color: Color(0xFF2585DE),
                  //   child: const Text(
                  //     'Pilih tanggal',
                  //     // textAlign: TextAlign.left,
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.normal,
                  //       fontSize: 15,
                  //       fontFamily: 'Nunito',
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 15),

                  // Input Jam
                  MaterialButton(
                    minWidth: double.infinity,
                    elevation: 3,
                    height: 50,
                    onPressed: pickTime,
                    color: Color(0xFF2585DE),
                    child: const Text(
                      'Pilih jam',
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        fontFamily: 'Nunito',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Tombol save & cancel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        minWidth: 102,
                        height: 40,
                        onPressed: () async {
                          final user = await AuthMethods().getUserDetails();
                          Provider.of<EventList>(context, listen: false)
                              .addList(
                                  const Uuid().v1(),
                                  Event(
                                      uid: user.uid,
                                      title: titleController.text,
                                      notes: subtitleController.text,
                                      time: timeSelected
                                          .format(context)
                                          .toString(),
                                      date: today));
                          // titleController.clear();
                          // subtitleController.clear();
                          Navigator.pop(context);
                        },
                        color: Color(0xFF2585DE),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ),
                      MaterialButton(
                        minWidth: 102,
                        height: 40,
                        onPressed: () => Navigator.of(context).pop(),
                        color: Color(0xFF2585DE),
                        child: const Text(
                          'Kembali',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
      // Mulai Kalender
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
                pageJumpingEnabled: true,
                calendarFormat: CalendarFormat.month,
                firstDay: DateTime.utc(DateTime.now().year, 1, 1),
                lastDay: DateTime.utc(DateTime.now().year, 12, 31),
                focusedDay: today,
                headerVisible: true,
                selectedDayPredicate: (day) => isSameDay(day, today),
                availableGestures: AvailableGestures.all,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    currentDate = DateFormat.yMd().format(selectedDay);
                    focusedDay = selectedDay;
                    today = selectedDay;
                    print(currentDate);
                    print(today);
                  });
                },
                onPageChanged: (focusedDay) {
                  today = focusedDay;
                },
                headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w800)),

                // Styling Calender
                calendarStyle: CalendarStyle(
                  todayTextStyle: TextStyle(fontSize: 20, color: Colors.white),
                  weekendDecoration: BoxDecoration(color: Colors.transparent),
                  weekendTextStyle: TextStyle(color: Colors.red),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    for (DateTime d in widget.toHighlight) {
                      if (day.day == d.day &&
                          day.month == d.month &&
                          day.year == d.year) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 51, 44, 189),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              child: Center(
                                  child: Text('${day.day}',
                                      style: const TextStyle(
                                          color: Colors.white))),
                            ),
                          ],
                        );
                      }
                    }
                    return null;
                  },
                )),

            Container(
              height: 10,
              color: Colors.blue,
              margin: EdgeInsets.only(bottom: 10),
            ),

            // Show date time
            Flexible(
              child: widget.marks[currentDate] == null
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            'Tidak ada event untuk hari ini: ' +
                                DateFormat('EEEE, d MMM yyyy')
                                    .format(today)
                                    .toString(),
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
                  : ListView.builder(
                      itemCount: widget.marks[currentDate]!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            EventListTile(
                              event: widget.marks[currentDate]![index],
                              deleteButton: (BuildContext) {},
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      },
                    ),
            ),
            // Container(
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //           begin: Alignment.topLeft,
            //           end: Alignment.bottomRight,
            //           colors: [
            //             Color(0xFF2585DE),
            //             Color(0xFFA4D3FF),
            //           ]),
            //     ),
            //     height: 80,
            //     width: double.infinity,
            //     padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
            //     alignment: Alignment.center,
            //     child: Text(DateFormat('EEEE, d MMM yyyy').format(today),
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //             color: Color.fromARGB(255, 255, 255, 255),
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold))),

            // Container(
            //     height: 280,
            //     child:
          ],
        ),
      ),
    );
  }
}
