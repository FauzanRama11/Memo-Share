import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar(
      {super.key, required int elevation, required Container flexibleSpace});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      // Profila Name
                      Text(
                        "Halo Wahyu",
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
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.person_rounded,
                      )),
                ],
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '"P ADU"',
                      style: TextStyle(
                          fontFamily: 'Nunito', color: Color(0xFF2585DE)),
                    ),
                    Text(
                      '- wahyu',
                      style: TextStyle(
                          fontFamily: 'Nunito', color: Color(0xFF2585DE)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
