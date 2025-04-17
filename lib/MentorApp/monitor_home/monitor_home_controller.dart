import 'package:get/get.dart';
import 'package:sprint1/MentorApp/monitor_home/classes_model.dart';
import 'package:sprint1/MentorApp/monitor_home/monitor_home_service.dart';

class MonitorHomeController extends GetxController {
  var isLoading = false.obs;
  var classes = <ClassesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchClasses();
  }

  void fetchClasses() async {
    try {
      isLoading(true);
      var classes = await MonitorHomeService().fetchClasses();
      this.classes.value = classes;
    } finally {
      isLoading(false);
    }
  }
}
