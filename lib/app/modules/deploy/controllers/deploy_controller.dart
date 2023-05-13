import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:github/github.dart';
import 'package:history_collab/app/shared/services/remote_config_service.dart';

class DeployController extends GetxController {
  GitHub? github;
  DatabaseReference? _database;
  DatabaseReference? _details;

  final mail = 'mizihan84@gmail.com';
  final slug = RepositorySlug('mahidul-islam', 'mock_server');

  final Rx<RepositoryCommit?> latestCommit = RepositoryCommit().obs;
  RxList<String> databases = RxList.empty();
  RxnString selectedDatabase = RxnString('sirah');
  TextEditingController articleNameController =
      TextEditingController(text: 'abdullah');

  RxnString articleFoundInFirebase = RxnString();
  RxnString articleFoundInGithub = RxnString();

  @override
  void onInit() async {
    github = GitHub(
        auth: Authentication.withToken(
            RemoteConfigService.to.githubPersonaToken));
    FirebaseDatabase.instance.databaseURL =
        'https://history-collab-default-rtdb.asia-southeast1.firebasedatabase.app/';
    _database = FirebaseDatabase.instance.ref();

    databases.addAll(RemoteConfigService.to.databases.split('`'));

    // latestCommit.value = await fetchLatestCommit();
    // printListOfTopic();
    // getAllDetailsPage();
    super.onInit();
  }

  Future<void> onCompare() async {
    unawaited(getSingleDetailsGithubPage());
    unawaited(getFirebaseArticle());
  }

  Future<void> getFirebaseArticle() async {
    _details = _database
        ?.child('$selectedDatabase/details/${articleNameController.text}');
    _details?.onValue.listen(
      (DatabaseEvent event) {
        final String? cacheMap = json.decode(json.encode(event.snapshot.value));
        articleFoundInFirebase.value = cacheMap ?? '--';
      },
    );
  }

  Future<RepositoryCommit?> fetchLatestCommit() async {
    // Fetch the default branch of the repository
    final Branch? branch = await github?.repositories.getBranch(slug, 'main');

    // Get the latest commit of the default branch
    final RepositoryCommit? latestCommit =
        await github?.repositories.getCommit(slug, branch?.commit?.sha ?? '');
    return latestCommit;
  }

  Future<void> printListOfTopic() async {
    const file = 'topic_list.json';
    // const content = 'New content';

    final currentFile = await github?.repositories.getContents(slug, file);
    // final path = currentFile.file?.path;
    // final sha = currentFile.file?.sha;
    print(currentFile?.file?.content);
  }

  Future<void> commit(String content, String path) async {
    // Create the commit
    await github?.repositories.createFile(
      slug,
      CreateFile(
        message: 'Commit message',
        content: content,
        path: path,
        branch: 'main',
      ),
    );
  }

  Future<void> getAllDetailsPage() async {
    const String folder = 'articles';

    // Get the contents of the folder
    final RepositoryContents? contents =
        await github?.repositories.getContents(slug, folder);

    // Print the names of the files in the folder
    if (contents != null) {
      for (final item in contents.tree!) {
        if (item.type == 'file') {
          print(item.name);
        }
      }
    }
  }

  Future<void> getSingleDetailsGithubPage() async {
    final String folder = 'articles/${articleNameController.text}.txt';

    // Get the contents of the folder
    final RepositoryContents? contents =
        await github?.repositories.getContents(slug, folder);

    // Print the names of the files in the folder
    if (contents != null && contents.isFile) {
      articleFoundInGithub.value = utf8.decode(base64.decode(
          (contents.file?.content ?? '').replaceAll(RegExp(r'\s+'), '')));
    }
  }
}
