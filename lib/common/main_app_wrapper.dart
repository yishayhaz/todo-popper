import 'package:flutter/material.dart';
import 'package:todo_popper/common/balloon_form.dart';
import 'package:todo_popper/common/navbar.dart';

class MainAppWrapper extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;

  const MainAppWrapper({super.key, required this.body, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        shape:
            ShapeBorder.lerp(const CircleBorder(), const StadiumBorder(), 0.5),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return const BalloonForm();
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const Navbar(),
      body: SafeArea(child: body),
    );
  }
}
