import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/repositories/repo.dart';

// Services are an extension of repositories.
// So imagine you have 2 repositories.
// And you want a provider to use the methods of both repositories to achieve a
// desired result. In that case, we can create a superset of the repositories
// and call it a "service".
// Simply put, the job of the service is to communicate between two or more
// repositories.

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
