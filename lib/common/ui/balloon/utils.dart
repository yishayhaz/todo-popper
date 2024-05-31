import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_popper/api/models/balloon.dart';

class BalloonUtils {
  static BalloonModal setPosition(BalloonModal balloon, BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    double size = media.size.width * importanceToSize[balloon.importance]!;
    double screenHeight = media.size.height -
        kBottomNavigationBarHeight -
        media.padding.top -
        media.padding.bottom;

    return balloon.copyWith(
      left: max(0, min(media.size.width - size, balloon.left)),
      top: max(0, min(screenHeight - size, balloon.top)),
    );
  }

  static TextStyle sizeToTextStyle(
      BalloonImportance importance, BuildContext context) {
    switch (importance) {
      case BalloonImportance.low:
        return Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(color: Colors.white);
      case BalloonImportance.medium:
        return Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: Colors.white);
      case BalloonImportance.high:
        return Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(color: Colors.white);
    }
  }
}

const Map<BalloonImportance, double> importanceToSize = {
  BalloonImportance.low: 1 / 8,
  BalloonImportance.medium: 1 / 4,
  BalloonImportance.high: 1 / 2,
};

const Map<BalloonImportance, int> importanceToMaxLines = {
  BalloonImportance.low: 2,
  BalloonImportance.medium: 3,
  BalloonImportance.high: 4,
};

const Map<BalloonImportance, double> importanceToPadding = {
  BalloonImportance.low: 6,
  BalloonImportance.medium: 12,
  BalloonImportance.high: 24,
};

const Map<BalloonImportance, double> sizeToChars = {
  BalloonImportance.low: 33,
  BalloonImportance.medium: 66,
  BalloonImportance.high: 99,
};

const balloonsColors = [
  Color(0xFF2133a1),
  Color(0xFFec2a5f),
  Color(0xFF30cb83),
  Color(0xFF9b59b6),
  Color(0xFFf1c40f),
];
