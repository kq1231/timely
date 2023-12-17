import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/repositories/pending_repo.dart';
import 'package:timely/modules/common/services/completion_service.dart';
import 'package:timely/modules/tab_11/models/tab_11_model.dart';
import 'package:timely/reusables.dart';

class Tab11ServiceNotifier extends AutoDisposeNotifier {
  @override
  build() {
    return;
  }

  Future<void> writeTab11Model(model) async {
    // Get the file
    final file = (await ref.read(dbFilesProvider.future)).tab11PendingFile;

    return ref.read(pendingRepositoryProvider.notifier).writeModel(model, file);
  }

  Future<List> fetchTab11Models() async {
    // Get the file

    final file = (await ref.read(dbFilesProvider.future)).tab11PendingFile;
    return (await ref
        .read(pendingRepositoryProvider.notifier)
        .fetchModels(Tab11Model.fromJson, file));
  }

  Future<void> markTab11ModelAsComplete(model) async {
    // Get the files
    final pendingFile =
        (await ref.read(dbFilesProvider.future)).tab11PendingFile;

    final completedFile =
        (await ref.read(dbFilesProvider.future)).tab11CompletedFile;

    return ref
        .read(completionServiceProvider.notifier)
        .markAsComplete(model, pendingFile, completedFile);
  }

  Future<void> deleteTab11Model(model) async {
    // Get the file
    final file = (await ref.read(dbFilesProvider.future)).tab11PendingFile;
    return ref
        .read(pendingRepositoryProvider.notifier)
        .deleteModel(model, file);
  }

  Future<void> editTab11Model(model) async {
    return ref.read(pendingRepositoryProvider.notifier).editModel(model, state);
  }
}

final tab11ServiceProvider =
    AutoDisposeNotifierProvider<Tab11ServiceNotifier, void>(
        Tab11ServiceNotifier.new);
