import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  DatabaseReference? _database;
  DatabaseReference? _cache;

  RxMap<String, dynamic> map = {'Zihan': 'vai'}.obs;

  @override
  void onInit() {
    FirebaseDatabase.instance.databaseURL =
        'https://history-collab-default-rtdb.asia-southeast1.firebasedatabase.app/';
    _database = FirebaseDatabase.instance.ref();
    _cache = _database?.child('sirah/');
    _cache?.onValue.listen(
      (DatabaseEvent event) => checkAndUpdate(event),
    );
    super.onInit();
  }

  void checkAndUpdate(DatabaseEvent event) {
    final Map<String, dynamic>? cacheMap =
        json.decode(json.encode(event.snapshot.value));
    map.value = cacheMap ?? {'New': 'default'};
    if (kDebugMode) {
      print(cacheMap);
    }
  }

  @override
  void onClose() {
    _database = null;
    _cache = null;
    super.onClose();
  }
}
