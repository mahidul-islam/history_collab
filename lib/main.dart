import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:history_collab/app/shared/services/remote_config_service.dart';
import 'package:history_collab/bindings.dart';
import 'package:history_collab/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  RemoteConfigService? remoteConfigService;
  remoteConfigService = await RemoteConfigService.getInstance();
  await remoteConfigService!.initialise();
  Get.put(remoteConfigService);
  runApp(
    GetMaterialApp(
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
