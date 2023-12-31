import 'dart:io';

import 'package:timely/common/list_struct/repositories/repo.dart';

class ListStructRepositoryService<T> extends ListStructRepositoryNotifier<T> {
  Future<void> markModelAsComplete(
      T model, File pendingFile, File completedFile) async {
    // Shift the model from pending DB to completed DB and refresh immediately
    // after model is removed from pending DB.
    await deleteModel(model, pendingFile);
    await writeModel(model, completedFile);
  }
}
