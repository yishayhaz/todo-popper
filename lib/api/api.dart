import 'hive.dart';
import 'package:todo_popper/api/models/balloon.dart';

class API {
  static create(BalloonModal balloon) async {
    return HiveDB.balloonsBox.put(balloon.id, balloon.toJson());
  }

  static update(BalloonModal balloon) async {
    return HiveDB.balloonsBox.put(balloon.id, balloon.toJson());
  }

  static delete(String balloonId) async {
    return HiveDB.balloonsBox.delete(balloonId);
  }

  static toggleDone(String balloonId) {
    BalloonModal balloon =
        BalloonModal.fromJson(HiveDB.balloonsBox.get(balloonId));

    BalloonModal updatedBalloon = balloon.copyWith(isDone: !balloon.isDone);

    return HiveDB.balloonsBox.put(balloon.id, updatedBalloon.toJson());
  }

  static List<BalloonModal> getBalloons() {
    return HiveDB.balloonsBox.values
        .toList()
        .map((e) => BalloonModal.fromJson(e))
        .toList();
  }
}
