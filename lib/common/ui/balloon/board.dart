import 'package:flutter/material.dart';
import 'package:todo_popper/api/models/balloon.dart';
import 'package:todo_popper/common/ui/balloon/balloon.dart';

class BalloonsBoard extends StatelessWidget {
  final List<BalloonModal> balloons;

  const BalloonsBoard({super.key, required this.balloons});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        color: Colors.grey.shade200,
        width: size.width,
        child: Stack(
          children: balloons.map((e) {
            return Balloon(
              balloon: e,
              key: Key(e.id),
            );
          }).toList(),
        ));
  }
}
