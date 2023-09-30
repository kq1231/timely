// TODO Inshaa Allah :: Create a controller for managing
// tab data for each tab
// Implement [ Change || State ]Notifier
// Controller will be used to both:
// .retrieve and .create data
// CRUD functions inside the controller
// create, update, read and delete

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
  // TODO :: .. Inshaa Allah for n tabs.

  Future<void> initTabs(String date) async {
    // Data initializations
    tabOneData =
        jsonDecode(await File("../data_pool/tab_1.json").readAsString()) as Map;
    // TODO :: .. Inshaa Allah for n tabs.

    // Assignments
    tabOne = TabOne(tabOneData, date);
    // TODO :: .. Inshaa Allah for n tabs.
  }

  void createTabOneData(
      {date,
      time_1,
      required text_1,
      required Map typeA,
      required Map typeB,
      required Map typeC,
      time_2}) {
    // Tab_1 input screen to be saved to db, Inshaa Allah

    // Create the date
    tabOneData[date] = {};
    Map types = {"type_a": typeA, "type_b": typeB, "typeC": typeC};

    // Add the types
    for (int n in Iterable.generate(types.keys.toList().length)) {
      tabOneData[date][types.keys.toList()[n]] = {
        "text_1": text_1,
        "children": [
          {
            "text_2": types.values.toList()[n]["text_2"],
            "time_1": time_1,
            "time_2": time_2,
            "rating": types.values.toList()[n]["rating"],
          },
        ],
      };
    }
  }
}
