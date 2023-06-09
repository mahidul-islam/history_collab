import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:history_collab/app/routes/app_pages.dart';

import '../controllers/list_controller.dart';

class ListView extends GetView<ListController> {
  const ListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Available Databases'),
        centerTitle: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
                child: MaterialButton(
                  padding: const EdgeInsets.all(20),
                  onPressed: () {
                    Get.toNamed(Routes.DEPLOY);
                  },
                  color: Colors.amberAccent,
                  child: const Text('DEPLOY TO SERVER'),
                ),
              ),
            ),
            for (int i = 0; i < controller.childList.length; i++)
              SizedBox(
                width: Get.width,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30, top: 30),
                  child: MaterialButton(
                    padding: const EdgeInsets.all(20),
                    onPressed: () {
                      Get.toNamed(Routes.HOME,
                          arguments: controller.childList[i]);
                    },
                    color: Colors.amberAccent,
                    child: Text(controller.childList[i]),
                  ),
                ),
              ),
            const SizedBox(height: 50),
          ],
        ));
      }),
    );
  }
}
