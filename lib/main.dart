import 'package:flutter/material.dart';
import 'package:todo_popper/api/hive.dart';
import 'package:todo_popper/common/router.dart';
import 'package:todo_popper/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveDB.init();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Todo Popper",
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: theme,
    );
  }
}
