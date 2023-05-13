import 'package:get/get.dart';
import 'package:history_collab/app/shared/services/remote_config_service.dart';

class ListController extends GetxController {
  RxList<String> childList = RxList.empty();
  // FirebaseRemoteConfig? remoteConfig;

  @override
  void onInit() async {
    // remoteConfig = FirebaseRemoteConfig.instance;
    // await remoteConfig?.fetchAndActivate();
    String? databases = RemoteConfigService.to.databases;
    childList.addAll(databases.split('`'));
    super.onInit();
  }
}
