import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/entry_controller.dart';

class EntryView extends GetView<EntryController> {
  const EntryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: controller.save,
        child: const Icon(Icons.save),
      ),
      appBar: AppBar(
        title: const Text('Edit/Create Entry'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Name'),
                const SizedBox(width: 40),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: controller.nameController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Date'),
                const SizedBox(width: 40),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: controller.dateController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Start'),
                const SizedBox(width: 40),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: controller.startController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('End'),
                const SizedBox(width: 40),
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: controller.endController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'(^-?\d*\.?\d*)'))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
