import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController with GetTickerProviderStateMixin {
  late List<AnimationController> scaleControllers;
  late List<Animation<double>> scaleAnimations;
  final GlobalKey<FlipCardState> flipKey = GlobalKey<FlipCardState>();
  var iconCards = <GlowIcon>[].obs;

  // we're showing 12 cards in the grid
  final int cardCount = 12;

  // List of unique keys
  late List<GlobalKey<FlipCardState>> flipKeys;

  @override
  void onInit() {
    super.onInit();

    //Creates a List of Cards
    createCardList();

    // Initialize animation controllers and animations for each card
    scaleControllers = List.generate(
      cardCount,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    scaleAnimations = scaleControllers
        .map(
          (controller) => Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut)),
        )
        .toList();

    // Initialize flip card keys
    flipKeys = List.generate(cardCount, (_) => GlobalKey<FlipCardState>());
  }
  // --------------------------------------------------------------------------------------------------

  void onFlip(int index) {
    final key = flipKeys[index];
    final scaleController = scaleControllers[index];

    if (key.currentState!.isFront) {
      key.currentState!.toggleCard();
      Future.delayed(const Duration(milliseconds: 300), () {
        scaleController.reverse();
      });
    } else {
      scaleController.forward();
      key.currentState!.toggleCard();
    }
  }

  // List of Card Icons
  List iconList = <GlowIcon>[
    GlowIcon(
      Icons.star_border,
      glowColor: CupertinoColors.systemYellow,
      size: 40,
      color: CupertinoColors.systemYellow,
    ),
    GlowIcon(
      CupertinoIcons.cloud,
      glowColor: Colors.red,
      size: 40,
      color: Colors.red,
    ),
    GlowIcon(
      CupertinoIcons.heart,
      glowColor: Colors.red,
      size: 40,
      color: Colors.red,
    ),
    GlowIcon(
      Icons.wb_sunny_outlined,
      glowColor: Colors.yellow,
      size: 40,
      color: Colors.yellow,
    ),
    GlowIcon(
      CupertinoIcons.moon,
      glowColor: Colors.white,
      size: 40,
      color: Colors.white,
    ),
    GlowIcon(
      CupertinoIcons.flame,
      glowColor: Colors.orange,
      size: 40,
      color: Colors.orange,
    ),
  ];

  // Create Card List
  void createCardList() {
    for (int i = 0; i < 6; i++) {
      iconCards.add(iconList[i % 6]);
      iconCards.add(iconList[i % 6]);
    }
    // Shuffle cars when first time created
    shuffleCards();
  }

  // Random Card Generator
  void shuffleCards() {
    iconCards.shuffle();
  }

  // START NEW GAME
  void startNewGame() async {
    // Turn all the Cards
    for (int i = 0; i < 12; i++) {
      flipKeys[i].currentState!.isFront
          ? null
          : flipKeys[i].currentState!.toggleCard();
    }
    // Creates New Random Cards with 1 sec delay, to update the Icons once the cards flipped.
    await Future.delayed(Duration(seconds: 1), () {
      shuffleCards();
    });
  }

  //-------------------------------------------------------------------------------------------------
  @override
  void onClose() {
    // Dispose all animation controllers
    for (var controller in scaleControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
