import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_popper/api/hive.dart';
import 'package:todo_popper/api/models/balloon.dart';
import 'package:todo_popper/common/main_app_wrapper.dart';
import 'package:todo_popper/common/ui/balloon/board.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    return MainAppWrapper(
        appBar: AppBar(
          title: const Text("Balloons to pop"),
        ),
        body: ValueListenableBuilder(
          valueListenable: HiveDB.balloonsBox.listenable(),
          builder: (context, box, widget) {
            return BalloonsBoard(balloons: BalloonModal.readManyFromBox(box));
          },
        ));
  }
}
