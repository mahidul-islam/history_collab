import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarNotification extends GetxService {
  static SnackbarNotification get to => Get.find();

  void error({required final String error, final bool forced = false}) {
    if (!forced) {
      if (Get.isBottomSheetOpen == true ||
          Get.isDialogOpen == true ||
          Get.isSnackbarOpen == true) {
        return;
      }
    } else {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      'ERROR',
      error.length > 160 ? 'Something Went Wrong!' : error,
      backgroundColor: Colors.redAccent.withOpacity(0.9),
      duration: 4.seconds,
      icon: const Icon(
        Icons.error_outline_rounded,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(
        bottom: 40,
        left: 16,
        right: 16,
      ),
      padding: const EdgeInsets.all(16),
      colorText: Colors.white,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text(
          'OK!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void success({
    required final String message,
    final String title = 'Success',
  }) {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.greenAccent.withOpacity(0.9),
      duration: 4.seconds,
      icon: const Icon(
        Icons.error_outline_rounded,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(
        bottom: 40,
        left: 16,
        right: 16,
      ),
      padding: const EdgeInsets.all(16),
      colorText: Colors.white,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text(
          'OK!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
