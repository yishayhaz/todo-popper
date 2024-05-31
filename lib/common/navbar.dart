import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_popper/common/router.dart';

const routes = ["/today", "/list"];

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    String currentRoute = AppRouter.location.toString();
    int currentIndex = routes.indexOf(currentRoute);

    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: (int index) {
        context.replace(routes[index]);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.now_widgets_rounded),
          label: 'Today',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list_rounded),
          label: 'List',
        ),
      ],
    );
  }
}
