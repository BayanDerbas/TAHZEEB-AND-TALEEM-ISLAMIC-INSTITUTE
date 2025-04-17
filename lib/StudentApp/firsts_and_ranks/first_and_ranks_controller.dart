import 'package:get/get.dart';

import 'first_and_ranks_model.dart';
import 'firsts_and_ranks_service.dart';

class FirstsAndRanksController extends GetxController {
  var endTime = 0.obs;
  var isStarted = false.obs;
  var isStudentStarted = false.obs;
  var isLoading = true.obs;
  var firstsAndRanksList = <FirstsAndRanksModel>[].obs;
  var answer = 0.obs;
  var isFinished = false.obs;
  var isPass = false.obs;

  @override
  void onInit() {
    fetchFirstsAndRanksList();
    super.onInit();
  }

  void fetchFirstsAndRanksList() async {
    try {
      isLoading(true);
      var firstsAndRanksList =
          await FirstsAndRanksService().fetchFirstAndRanks();
      this.firstsAndRanksList.value = firstsAndRanksList;
    } finally {
      isLoading(false);
    }
  }
}
