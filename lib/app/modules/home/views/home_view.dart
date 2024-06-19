import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:history_collab/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.ENTRY, arguments: [
                null,
                controller.entries.length,
                controller.database,
              ]);
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text('History Collaboration Portal'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 12),
                Container(
                  // color: Colors.amberAccent,
                  alignment: Alignment.center,
                  // padding: const EdgeInsets.all(40),
                  width: Get.width,
                  height: 50,
                  child: Text(
                    (controller.database ?? 'Hello').toUpperCase(),
                    style: const TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 12),
                Stack(
                  children: <Widget>[
                    Scrollbar(
                      thumbVisibility: true,
                      controller: controller.scrollController,
                      child: SingleChildScrollView(
                        controller: controller.scrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          color: Colors.white,
                          child: DataTable(
                            dataRowMinHeight: 92,
                            dataRowMaxHeight: 92,
                            columnSpacing: 30,
                            columns: [
                              for (int j = 0;
                                  j < controller.tableHeads.length;
                                  j++)
                                DataColumn(
                                  label: Expanded(
                                    child: Center(
                                      child: Text(
                                        controller.tableHeads[j],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  // onSort: (final columnIndex, final ascending) => true,
                                ),
                            ],
                            rows: [
                              for (int i = 0;
                                  i < controller.entries.length;
                                  i++)
                                DataRow(
                                  color:
                                      WidgetStateProperty.resolveWith<Color?>(
                                    (final Set<WidgetState> states) {
                                      return Colors.white;
                                    },
                                  ),
                                  cells: <DataCell>[
                                    DataCell(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(controller.entries[i].label ??
                                              '--'),
                                        ],
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(controller.entries[i].date
                                                  ?.toString() ??
                                              '--'),
                                        ],
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(controller.entries[i].start
                                                  ?.toString() ??
                                              '--'),
                                        ],
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(controller.entries[i].end
                                                  ?.toString() ??
                                              '--'),
                                        ],
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(controller.entries[i].article ??
                                              '--'),
                                        ],
                                      ),
                                      onTap: () {
                                        Get.toNamed(Routes.ARTICLE, arguments: [
                                          controller.entries[i],
                                          i,
                                          controller.database,
                                        ]);
                                      },
                                    ),
                                    DataCell(
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [Icon(Icons.edit)],
                                      ),
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.ENTRY,
                                          arguments: [
                                            controller.entries[i],
                                            i,
                                            controller.database,
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
    });
  }
}
