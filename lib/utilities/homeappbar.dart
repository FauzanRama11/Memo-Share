import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/model/user.dart' as model;
import '../provider/userProvider.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
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
                          SizedBox(height: 20),
                        ],
                      ),

                      // Profile Pict
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.transparent,
                        ),
                        child: user.photoUrl.isEmpty
                            ? CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage("images/profile-user.png"),
                              )
                            : CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  user.photoUrl,
                                )),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                            child: Column(
                          children: const [
                            SizedBox(height: 10),
                            Text(
                              '"Sepertinya aku tidak melakukan apa-apa, tetapi di kepalaku, aku cukup sibuk."',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Color(0xFF2585DE)),
                            ),
                            Text(
                              '- someone',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Color(0xFF2585DE)),
                            ),
                            SizedBox(height: 10)
                          ],
                        ))
                      ],
                    ),
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