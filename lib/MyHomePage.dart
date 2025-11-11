import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:memory_matching_game/card.dart';
import 'package:memory_matching_game/homeController.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final Homecontroller controller = Get.find<Homecontroller>();
  @override
  Widget build(BuildContext context) {
    // Makes Random Cards
    // controller.makeCardList();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo.shade700,
                // Colors.indigo.shade200,
                Colors.indigo.shade900,
              ],
              begin: Alignment.topLeft,
              end: AlignmentGeometry.bottomRight,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 70),
              // TITLE
              GlowText(
                'Memorica',
                glowColor: Colors.black,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'good timing',
                ),
              ),
              SizedBox(height: 15),
              // MATCHES FOUND
              Text(
                "Matches Found : 2 of 6",
                style: TextStyle(
                  color: Colors.grey[100],
                  fontSize: 18,
                  fontFamily: 'Pixel Game',
                ),
              ),
              SizedBox(height: 40),
              // GAME BOARD
              Container(
                margin: EdgeInsets.all(25),
                padding: EdgeInsets.all(20.0),
                height: 470,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade700.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.indigo),
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // mainAxisSpacing: 3.0,
                    // crossAxisSpacing: 10.0
                  ),
                  itemCount: controller.cardCount,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => CustomCard(
                        index: index,
                        icon: controller.iconCards[index],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 30),
              // START NEW GAME BUTTON
              SizedBox(
                height: MediaQuery.sizeOf(context).width * 0.14,
                width: MediaQuery.sizeOf(context).width * 0.48,
                child: TextButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10.0),
                      ),
                    ),
                    side: WidgetStatePropertyAll(
                      BorderSide(color: Colors.red.shade300, width: 2),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.indigo.shade800,
                    ),
                    overlayColor: WidgetStatePropertyAll(Colors.black12),
                  ),
                  onPressed: controller.startNewGame,
                  child: Text(
                    'Start New Game',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'good timing',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
