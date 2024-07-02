import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_collab/app/routes/app_pages.dart';
import '../controllers/list_controller.dart';
import '../modal/modal.dart';

class ListView extends GetView<ListController> {
  const ListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        floatingActionButton: (controller.user.value == null)
            ? FloatingActionButton.large(
                onPressed: () {
                  Get.dialog(
                    LoginModal(
                      controller: controller,
                    ),
                    barrierDismissible: false,
                  );
                },
                child: const Text(
                  'Log In!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            : FloatingActionButton.large(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text(
                  'Salam ${controller.userData.value?.userName ?? ""}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
        appBar: AppBar(
          title: const Text('List Of Available Databases'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: Get.width,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30, top: 30),
                  child: MaterialButton(
                    padding: const EdgeInsets.all(20),
                    onPressed: () {
                      Get.toNamed(Routes.DEPLOY);
                    },
                    color: Colors.greenAccent,
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
          ),
        ),
      );
    });
  }
}
