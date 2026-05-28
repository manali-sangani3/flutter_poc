import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Background task running");

    return Future.value(true);
  });
}
