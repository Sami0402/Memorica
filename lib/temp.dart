import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:memory_matching_game/card.dart';
import 'package:memory_matching_game/dialogbox.dart';

class Temp extends StatelessWidget {
  const Temp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              GlowContainer(
                height: MediaQuery.sizeOf(context).height * 0.20,
                width: MediaQuery.sizeOf(context).height * 0.3,
                borderRadius: BorderRadius.circular(12),
                // margin: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                color: Colors.indigo[500],
                glowColor: Colors.white,
                // glowColor: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Text(
                      "You Win!",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontFamily: "Pixel Game",
                        fontSize: 45,
                      ),
                    ),
                    Text(
                      "Wanna Play Again ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Good timing",
                        fontSize: 15,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.amberAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Play Again!",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Get.dialog(
                    customDialogbox(),
                    barrierDismissible: true,
                  );
                },
                child: Text("Tap"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


