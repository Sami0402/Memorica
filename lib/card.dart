import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:memory_matching_game/homeController.dart';

class CustomCard extends StatelessWidget {
  final int index;
  final GlowIcon icon;
  const CustomCard({super.key, required this.index, required this.icon});

  @override
  Widget build(BuildContext context) {
    final Homecontroller controller = Get.find<Homecontroller>();
    return GestureDetector(
      onTap: () => controller.onFlip(index),
      child: FlipCard(
        key: controller.flipKeys[index],
        flipOnTouch: true,
        speed: 300,
        // FRONT
        front: Container(
          margin: EdgeInsets.all(6),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.indigo[900],
            borderRadius: BorderRadius.circular(12),
            border: BoxBorder.all(color: Colors.indigo.shade400, width: 2.5),
          ),
        ),
        // BACK
        back: Container(
          margin: EdgeInsets.all(2),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: BoxBorder.all(color: Colors.indigo.shade400, width: 2.5),
          ),
          child: Center(
            child: AnimatedBuilder(
              animation: controller.scaleAnimations[index],
              builder: (_, child) {
                return Transform.scale(
                  scale: controller.scaleAnimations[index].value,
                  child: child,
                );
              },
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
