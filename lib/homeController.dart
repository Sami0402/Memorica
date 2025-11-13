import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:memory_matching_game/dialogbox.dart';

class Homecontroller extends GetxController with GetTickerProviderStateMixin {
  late List<AnimationController> scaleControllers;
  late List<Animation<double>> scaleAnimations;
  final GlobalKey<FlipCardState> flipKey = GlobalKey<FlipCardState>();
  final RxList<Map<String, dynamic>> iconCards = <Map<String, dynamic>>[].obs;
  final currentScore = 0.obs;
  final totalScore = 6;

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
        duration: const Duration(milliseconds: 180),
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

    // Attach animations AFTER widgets have rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeCardAnimations();
    });

    // Initialize flip card keys
    flipKeys = List.generate(cardCount, (_) => GlobalKey<FlipCardState>());
  }

  void _initializeCardAnimations() {
    for (int i = 0; i < cardCount; i++) {
      scaleControllers[i].value = 1.0; // initial scale
    }
  }

  // --------------------------------------------------------------------------------------------------

  // Game Mech
  List iconIndex = [].obs;
  List<GlobalKey<FlipCardState>> cardKeys = <GlobalKey<FlipCardState>>[];
  int cnt = 0;
  var glow = RxBool(true);
  void matchTheCards(int index) async {
    glow.value = true;
    cnt = cnt + 1;
    iconIndex.add(iconCards[index]['index']);
    cardKeys.add(flipKeys[index]);
    onFlip(index);
    print(iconIndex);
    print(cnt);
    if (cnt == 2) {
      cnt = 0;
      glow.value = false;
      await Future.delayed(
        Duration(milliseconds: 300),
        () => glow.value = false,
      );
      if (iconIndex[0] == iconIndex[1]) {
        glow.value = false;
        print('Works');
        currentScore.value += 1;
        cardKeys.clear();
        iconIndex.clear();
        cnt = 0;
      } else {
        await Future.delayed(Duration(milliseconds: 300), () {
          for (var key in cardKeys) {
            key.currentState!.toggleCard();
          }
        });
        cardKeys.clear();
        iconIndex.clear();
      }
      cnt = 0;
      if (currentScore.value == totalScore) {
        Get.dialog(customDialogbox());
      }
    }
  }

  void onFlip(int index) {
    final key = flipKeys[index];
    final scaleController = scaleControllers[index];

    if (key.currentState!.isFront) {
      // FRONT → BACK

      // Always reset animation BEFORE flipping
      scaleController.value = 1.0;

      key.currentState!.toggleCard();

      Future.delayed(const Duration(milliseconds: 300), () {
        scaleController.reverse(); // scale from 1 → 0
      });
    } else {
      // BACK → FRONT

      // Reset scale BEFORE flipping back
      scaleController.value = 0.0;

      scaleController.forward(); // scale from 0 → 1

      key.currentState!.toggleCard();
    }
  }

  // void onFlip(int index) {
  //   final key = flipKeys[index];
  //   final scaleController = scaleControllers[index];

  //   // Flips the card with Animation
  //   if (key.currentState!.isFront) {
  //     key.currentState!.toggleCard();
  //     Future.delayed(const Duration(milliseconds: 300), () {
  //       scaleController.reverse();
  //     });
  //   } else {
  //     scaleController.forward();
  //     key.currentState!.toggleCard();
  //   }
  // }

  // Icon with Index Map
  List<Map<String, dynamic>> icons = [
    {
      'index': 0,
      'Icon': GlowIcon(
        Icons.star_border,
        glowColor: CupertinoColors.systemYellow,
        size: 40,
        color: CupertinoColors.systemYellow,
      ),
    },
    {
      'index': 1,
      'Icon': GlowIcon(
        CupertinoIcons.cloud,
        glowColor: Colors.red,
        size: 40,
        color: Colors.red,
      ),
    },
    {
      'index': 2,
      'Icon': GlowIcon(
        CupertinoIcons.heart,
        glowColor: Colors.red,
        size: 40,
        color: Colors.red,
      ),
    },
    {
      'index': 3,
      'Icon': GlowIcon(
        Icons.wb_sunny_outlined,
        glowColor: Colors.yellow,
        size: 40,
        color: Colors.yellow,
      ),
    },
    {
      'index': 4,
      'Icon': GlowIcon(
        CupertinoIcons.moon,
        glowColor: Colors.white,
        size: 40,
        color: Colors.white,
      ),
    },
    {
      'index': 5,
      'Icon': GlowIcon(
        CupertinoIcons.flame,
        glowColor: Colors.orange,
        size: 40,
        color: Colors.orange,
      ),
    },
  ];

  // Create Card List
  void createCardList() {
    for (int i = 0; i < 6; i++) {
      iconCards.add(icons[i % 6]);
      iconCards.add(icons[i % 6]);
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
    // Reset Score
    currentScore.value = 0;
    cardKeys.clear();
    iconIndex.clear();
    cnt = 0;
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
