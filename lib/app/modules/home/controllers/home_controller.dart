import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:history_collab/app/modules/home/model/entry.dart';
import '../model/user_model.dart';

class HomeController extends GetxController {
  Rx<UserData?> userData = Rx(null);
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController logemailController = TextEditingController();
  TextEditingController logpassController = TextEditingController();

  DatabaseReference? _database;
  DatabaseReference? _index;
  DatabaseReference? _details;
  String? database;

  RxMap<String, dynamic> map = {'Zihan': 'vai'}.obs;

  ScrollController scrollController = ScrollController();

  List<String> tableHeads = <String>[
    'Label',
    'Date',
    'Start',
    'End',
    'Article',
    'Edit',
  ];

  RxList<Entry> entries = RxList.empty();

  @override
  void onInit() {
    database = Get.arguments as String?;
    database ??= 'sirah';
    FirebaseDatabase.instance.databaseURL =
        'https://history-collab-default-rtdb.asia-southeast1.firebasedatabase.app/';
    _database = FirebaseDatabase.instance.ref();
    _index = _database?.child('$database/index/');
    _details = _database?.child('$database/details/');
    _index?.onValue.listen(
      (DatabaseEvent event) => checkAndUpdate(event),
    );
    super.onInit();
  }

  Future<void> getUserName(User? user) async {
    if (user == null) {
      userData.value = null;
      return;
    }
    final DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .get();
    final Map<String, dynamic> json = data.data() ?? {};
    userData.value = UserData.fromJson(json);
  }

  void register() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passController.text,
    )
        .then(
      (UserCredential cred) {
        userData.value = UserData(
          userName: nameController.text,
          email: emailController.text,
          role: 'User',
        );
        saveUser(cred.user?.uid);
        Get.back();
      },
    );
  }

  void login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: logemailController.text,
        password: logpassController.text,
      );
      Get.back();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('WEAK!', 'Password Provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('REPEAT!', 'Email Provided already Exists');
      } else if (e.code == 'invalid-credential') {
        Get.snackbar('WRONG!', 'Email and Password does not match');
      }
    } catch (e) {
      Get.snackbar('Authentication error!', e.toString());
    }
  }

  Future<void> saveUser(String? uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
          userData.value?.toJson() ?? {},
        );
  }

  void checkAndUpdate(DatabaseEvent event) {
    if (event.snapshot.value != null) {
      entries.clear();
      final List<dynamic> cacheMap =
          json.decode(json.encode(event.snapshot.value));
      for (int i = 0; i < cacheMap.length; i++) {
        entries.add(Entry(
          label: cacheMap[i]['label'],
          article: cacheMap[i]['article'],
          date: cacheMap[i]['date'],
          start: cacheMap[i]['start'],
          end: cacheMap[i]['end'],
        ));
      }
    }
  }

  @override
  void onClose() {
    _database = null;
    _index = null;
    _details = null;
    super.onClose();
  }

  // This was used to add firebase index database from asset.
  Future<void> uploadAllDataList() async {
    final String res = await rootBundle.loadString('assets/topic_list.json');
    final List<dynamic> li = json.decode(res);
    _index?.set(li);
  }

  // This was used to add firebase details database from asset
  // for all article details.
  Future<void> uploadAllDetailsFiles() async {
    String assets = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(assets);
    final articlesInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/articles") && path.contains(".txt"))
        .toList();
    final Map<String, String> detailsMap = {};
    for (int i = 0; i < articlesInAssets.length; i++) {
      String key = articlesInAssets[i].split('/').last.split('.').first;
      String value = await rootBundle.loadString(articlesInAssets[i]);
      Map<String, String> local = {key: value};
      detailsMap.addAll(local);
    }
    _details?.set(detailsMap);
  }
}
