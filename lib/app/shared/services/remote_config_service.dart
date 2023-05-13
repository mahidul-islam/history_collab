// ignore_for_file: constant_identifier_names

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';

const String GITHUB_PERSONAL_TOKEN = 'github_commit_token';
const String LIST_USERS = 'users';
const String LIST_DATABASES = 'databases';

class RemoteConfigService {
  RemoteConfigService({required FirebaseRemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  static RemoteConfigService get to => Get.find();

  final FirebaseRemoteConfig _remoteConfig;
  final Map<String, dynamic> defaults = <String, dynamic>{
    GITHUB_PERSONAL_TOKEN: '',
    LIST_USERS: '',
    LIST_DATABASES: 'sirah`test',
  };

  static RemoteConfigService? _instance;
  static Future<RemoteConfigService?> getInstance() async {
    _instance ??= RemoteConfigService(
      remoteConfig: FirebaseRemoteConfig.instance,
    );
    return _instance;
  }

  Future<FirebaseRemoteConfig> initialise() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          minimumFetchInterval: const Duration(minutes: 10),
          fetchTimeout: const Duration(minutes: 1),
        ),
      );
      await _remoteConfig.setDefaults(defaults);
      await fetchAndActivate();
    } catch (_) {}
    return Future<FirebaseRemoteConfig>.value(_remoteConfig);
  }

  Future<void> fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  String get githubPersonaToken =>
      _remoteConfig.getString(GITHUB_PERSONAL_TOKEN);
  String get databases => _remoteConfig.getString(LIST_DATABASES);
  String get users => _remoteConfig.getString(LIST_USERS);
}
