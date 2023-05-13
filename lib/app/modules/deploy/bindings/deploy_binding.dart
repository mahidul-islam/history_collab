import 'package:get/get.dart';

import '../controllers/deploy_controller.dart';

class DeployBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeployController>(
      () => DeployController(),
    );
  }
}
