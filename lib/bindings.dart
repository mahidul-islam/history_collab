import 'package:get/get.dart';
import 'package:history_collab/app/shared/services/user_service.dart';

class InitialBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut(() => UserService());
  }
}
