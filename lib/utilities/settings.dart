import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/Resource/AuthMethod.dart';
import '/screens/login_screen.dart';
//https://www.google.com/url?sa=i&url=https%3A%2F%2Fpalembang.tribunnews.com%2F2018%2F04%2F30%2Fbetulkah-mitos-foto-bertiga-sebabkan-kematian-beginilah-penjelasannya-yang-harus-anda-ketahui&psig=AOvVaw0gpq8mswBH8OWLwA8hfK94&ust=1685523392720000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCIDur4rWnP8CFQAAAAAdAAAAABAE

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Sekilas Tentang Kami",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Container(
              child: Image.asset('images/kita.jpg'),
              height: 250,
              width: 350,
            ),
            Container(
              child: Text(
                "        Perkenalkan kami adalah mahasiswa semester 4 dari prodi Sistem Informasi Universitas Airlangga. Berikut adalah nama anggota tim kami : \n\n1. Daffa Frarhan R. (026)\n2. Wahyu Riyan H. (079)\n3. Muhammad Fauzan R. (080)\n\nTerima kasih sudah menggunakan aplikasi kami:)",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  await AuthMethods().signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  "SIGN OUT",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 2.2,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close"),
                  ),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
