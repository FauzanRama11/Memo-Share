import 'package:flutter/material.dart';
import '/utilities/settings.dart';
import 'package:provider/provider.dart';
import '/model/user.dart' as model;

import '../provider/userProvider.dart';

class PublicAppBar extends StatefulWidget {
  const PublicAppBar({super.key});

  @override
  State<PublicAppBar> createState() => _PublicAppBarState();
}

class _PublicAppBarState extends State<PublicAppBar> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2585DE),
                  Color(0xFFA4D3FF),
                ]),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          // Profila Name
                          Text(
                            "Halo " + user.username,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Nunito',
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Saat ini kamu punya x tugas",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Nunito',
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),

                      // Profile Pict
                      Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.transparent,
                          ),
                          child: IconButton(
                              icon: Icon(Icons.logout),
                              iconSize: 30,
                              color: Colors.white,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SettingsPage()));
                              })),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
  

// Slidable(
//  endActionPane: ActionPane(motion: StretchMotion(), children: [
//                 SlidableAction(
//                   onPressed: deleteTask,
//                   icon: Icons.delete_forever_rounded,
//                   foregroundColor: Colors.black,
//                   autoClose: true,
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(15),
//                       bottomRight: Radius.circular(15)),
//                   backgroundColor: Colors.red,
//                 ),
//               ]),
// )