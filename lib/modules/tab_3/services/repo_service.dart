import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/repositories/repo.dart';

// Repositories are used to communicate to the external world eg. DB, REST API.

class Tab3RepositoryServiceNotifier extends Tab3RepositoryNotifier {
  @override
  build() {
    return;
  }

  Future<void> markAsComplete(
      Tab3Model model, pendingFile, completedFile) async {
    // Delete entry from pending and add it to completed.
    await deleteModel(model, pendingFile);
    await writeModel(model, completedFile);
  }
}

final tab3RepositoryServiceProvider =
    NotifierProvider<Tab3RepositoryServiceNotifier, void>(
        Tab3RepositoryServiceNotifier.new);
