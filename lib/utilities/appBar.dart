import 'package:flutter/material.dart';

class FullAppBar extends StatelessWidget {
  const FullAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profila Name
              Text(
                "Halo Wahyu",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Nunito',
                  color: Color(0xFF2585DE),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Saat ini kamu punya x tugas",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Nunito',
                    color: Color(0xFF2585DE),
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),

          // Profile Pict
          Icon(Icons.person_rounded)
        ],
      ),
    );
  }
}
