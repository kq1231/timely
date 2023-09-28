// TODO Inshaa Allah :: Create a controller for managing
// tab data for each tab
// Implement [ Change || State ]Notifier
// Controller will be used to both:
// .retrieve and .create data
// CRUD functions inside the controller
// Edit, create, update and delete

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/models/tabs.dart';

final tabsDataProvider = ChangeNotifierProvider<TabsDataNotifier>((ref) {
  return TabsDataNotifier();
});

class TabsDataNotifier extends ChangeNotifier {
  // Tab data declarations
  late Map tabOneData;
  // TODO :: .. Inshaa Allah for n tabs.

  // Tab declarations
  late TabOne tabOne;
  // TODO :: .. Inshaa Allah

  Future<void> initTabs(String date) async {
    // Data initializations
    tabOneData =
        jsonDecode(await File("../data_pool/tab_1.json").readAsString()) as Map;
    // ...

    // Assignments
    tabOne = TabOne(tabOneData, date);
    // TODO :: .. Inshaa Allah for n tabs.
  }

  void createTabOneData() {
    // Tab_1 input screen to be saved to db, Inshaa Allah
  }
  // TODO :: .. Inshaa Allah for n tabs.
}
