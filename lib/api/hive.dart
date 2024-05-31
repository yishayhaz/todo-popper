import "package:hive_flutter/hive_flutter.dart";

class HiveDB {
  static late Box balloonsBox;

  static init() async {
    await Hive.initFlutter();
    balloonsBox = await Hive.openBox(
      'balloons',
    );
  }
}
