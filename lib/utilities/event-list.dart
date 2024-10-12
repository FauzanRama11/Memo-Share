import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../model/event.dart';

// ======================================== CREATE TO-DO LIST ========================================

class EventListTile extends StatelessWidget {
  final Event event;
  // Function(BuildContext)? taskChange;
  Function(BuildContext)? deleteButton;

  EventListTile({super.key, required this.event, required this.deleteButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 15, left: 15),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteButton,
              icon: Icons.delete_forever_rounded,
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: Container(
          child: Material(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.green),
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Progres kamu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.run_circle_outlined,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kegiatan:',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  Text(
                                    event.title,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.note_alt_outlined,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Keterangan:',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  Text(
                                    event.notes,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tanggal:',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  Text(
                                    DateFormat('EEEE, d MMM, yyyy')
                                        .format(event.date),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_sharp,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jam:',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  Text(
                                    event.time,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                            child: Text('Tandai'),
                            onPressed: () {
                              // Provider.of<EventList>(context, listen: false)
                              //     .changeStatus(event);
                            }),
                      ],
                    );
                  },
                );
              },
              // shape:
              //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              leading: Icon(
                event.isDone
                    ? Icons.check_circle_rounded
                    : Icons.pending_actions_rounded,
                color: event.isDone ? Colors.green : Color(0xFF2585DE),
              ),
              title: Text(
                event.title,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color:
                        event.isDone ? Color(0xFF9AC8F4) : Color(0xFF2585DE)),
              ),
              subtitle: Text(
                event.notes,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    color:
                        event.isDone ? Color(0xFF9AC8F4) : Color(0xFF2585DE)),
              ),
              trailing: Text(
                event.time,
                style: TextStyle(
                  color: Color(0xFF8C8C8C),
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
