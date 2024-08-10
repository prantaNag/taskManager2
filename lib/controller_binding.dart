import 'package:get/get.dart';
import 'package:taskmanager/ui/controllers/sign_in_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
