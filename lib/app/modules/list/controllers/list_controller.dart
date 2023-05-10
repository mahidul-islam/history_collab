import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';

class ListController extends GetxController {
  RxList<String> childList = RxList.empty();
  FirebaseRemoteConfig? remoteConfig;

  @override
  void onInit() async {
    remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig?.fetchAndActivate();
    String? databases = remoteConfig?.getString('databases');
    childList.addAll(databases?.split('`') ?? []);
    super.onInit();
  }
}
