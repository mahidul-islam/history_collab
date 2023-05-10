import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ModalUtil {
  static ModalUtil get to => Get.find();
  Future<void> showTwoButtonModal({
    required final String title,
    final String? cancelButtonTitle,
    final String? submitButtonTitle,
    required final List<Widget> contents,
    final Function? cancelOnPressed,
    final Function? submitOnPressed,
  }) async {
    final Widget alertWidget = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      actionsOverflowButtonSpacing: 8,
      content: StatefulBuilder(
        builder: (
          final BuildContext builderContext,
          final void Function(void Function()) dialogState,
        ) {
          return SingleChildScrollView(
            child: SizedBox(
              width: 560,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 32),
                  ...contents,
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        color: Colors.amberAccent,
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Cancel'),
                      ),
                      MaterialButton(
                        color: Colors.greenAccent,
                        onPressed: () {
                          submitOnPressed?.call();
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    await Get.dialog(alertWidget);
  }

  Future<void> showSingleButtonModal({
    required final String title,
    required final String buttonTitle,
    required final List<Widget> contents,
    final Function? onPressed,
  }) async {
    final Widget alertWidget = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      actionsOverflowButtonSpacing: 8,
      content: StatefulBuilder(
        builder: (
          final BuildContext builderContext,
          final void Function(void Function()) dialogState,
        ) {
          return SingleChildScrollView(
            child: SizedBox(
              width: 560,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 32),

                  ...contents,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: <Widget>[
                  //     SizedBox(
                  //       width: 164,
                  //       height: 48,
                  //       child: BarButton.primary(
                  //         onPressed: () {
                  //           onPressed?.call() ?? Get.back();
                  //         },
                  //         title: buttonTitle,
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );

    await Get.dialog(alertWidget);
  }

  Future<void> showbasicModal({
    required final List<Widget> contents,
  }) async {
    final Widget alertWidget = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      actionsOverflowButtonSpacing: 8,
      content: StatefulBuilder(
        builder: (
          final BuildContext builderContext,
          final void Function(void Function()) dialogState,
        ) {
          return SingleChildScrollView(
            child: SizedBox(
              width: 560,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...contents,
                ],
              ),
            ),
          );
        },
      ),
    );

    await Get.dialog(alertWidget);
  }
}
