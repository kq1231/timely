import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/reusables.dart';

// Repositories are used to communicate to the external world eg. DB, REST API.

class Tab3CompletedRepositoryNotifier extends Notifier<AsyncValue<void>> {
  @override
  build() {
    return const AsyncData(null);
  }

  Future<void> writeModelAsComplete(Tab3Model model) async {
    final file = (await ref.read(dbFilesProvider.future))[3]![1];
    Map jsonContent = jsonDecode(await file.readAsString());

    jsonContent = {...jsonContent, ...model.toJson()};

    await file.writeAsString(jsonEncode(jsonContent));
  }
}

final tab3CompletedRepositoryProvider =
    NotifierProvider<Tab3CompletedRepositoryNotifier, AsyncValue<void>>(
        Tab3CompletedRepositoryNotifier.new);
