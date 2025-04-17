import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'activity_model.dart';
import 'activity_service.dart';

class ActivityController extends GetxController {
  var endTime = 0.obs;
  var isStarted = false.obs;
  var error = false.obs;
  var isStudentStarted = false.obs;
  var isLoading = true.obs;
  var activity = ActivityModel().obs;
  var answer = 0.obs;
  var isFinished = false.obs;
  var isPass = false.obs;

  @override
  void onInit() {
    fetchActivity();
    super.onInit();
  }

  void fetchActivity() async {
    try {
      isLoading(true);
      var activity = await ActivityService().fetchActivity();
      this.activity.value = activity!;
      DateTime now = DateTime.now();
      DateTime targetTime = DateFormat('HH:mm:ss').parse(activity.startTime!);

      // Adjust the targetTime to today's date
      targetTime = DateTime(now.year, now.month, now.day, targetTime.hour,
          targetTime.minute, targetTime.second);

      // Calculate the duration difference
      Duration difference;
      if (targetTime.isAfter(now)) {
        difference = targetTime.difference(now);
        endTime(
            DateTime.now().millisecondsSinceEpoch + difference.inMilliseconds);
        isStarted(false);
        if (endTime.value <= 0) isStarted(true);
        print(endTime.value);
      } else {
        // If target time is before the current time, calculate the difference for the next day
        isStarted(true);
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      error(true);
    }
  }

  void compareAnswer() {
    isFinished(true);
    if (answer.value == int.parse(activity.value.correctAnswer!)) {
      isPass(true);
    }
  }
}
