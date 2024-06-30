import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class RegistrationModal extends StatelessWidget {
  const RegistrationModal({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(250, 100, 250, 100),
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    contentPadding: EdgeInsets.all(10),
                    labelText: "Enter Name",
                  ),
                  autofocus: true,
                  autocorrect: false,
                  autofillHints: const [AutofillHints.name],
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    hintText: "abc@email.com",
                    contentPadding: EdgeInsets.all(10),
                    labelText: "Enter Email",
                  ),
                  autofocus: true,
                  autocorrect: false,
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.passController,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    contentPadding: EdgeInsets.all(10),
                    labelText: "Enter Password",
                  ),
                  obscureText: true,
                  autofocus: true,
                  autocorrect: false,
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.register();
                        Get.back();
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginModal extends StatelessWidget {
  const LoginModal({
    super.key,
    required this.controller,
  });
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(250, 100, 250, 100),
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller.logemailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    contentPadding: EdgeInsets.all(10),
                    labelText: "Enter Email",
                  ),
                  autofocus: true,
                  autocorrect: false,
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.logpassController,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    contentPadding: EdgeInsets.all(10),
                    labelText: "Enter Password",
                  ),
                  obscureText: true,
                  autocorrect: false,
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.login();
                        Get.back();
                      },
                      child: const Text('Log in'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
