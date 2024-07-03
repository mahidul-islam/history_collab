import 'package:get/get.dart';
import 'package:history_collab/app/modules/list/model/user_model.dart';

class UserService extends GetxService {
  static UserService get to => Get.find();
  Rx<UserData?> userData = Rx(null);
}
