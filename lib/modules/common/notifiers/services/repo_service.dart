import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/notifiers/repositories/repository.dart';

class RepositoryService<T> extends Notifier<void> {
  late final RepositoryNotifier<T> pendingRepository;

  RepositoryService() {
    this.pendingRepository = RepositoryNotifier<T>();
  }

  Future<void> writeModel(T model, File file) async {
    await pendingRepository.writeModel(model, file);
  }

  Future<List<T>> fetchModels(Function modelizer, File file) async {
    return await pendingRepository.fetchModels(modelizer, file);
  }

  Future<void> deleteModel(T model, File file) async {
    await pendingRepository.deleteModel(model, file);
  }

  Future<void> editModel(T model, File file) async {
    await pendingRepository.editModel(model, file);
  }

  Future<void> markModelAsComplete(
      T model, File pendingFile, File completedFile) async {
    // Shift the model from pending DB to completed DB and refresh immediately
    // after model is removed from pending DB.
    await ref.read(repositoryProvider.notifier).deleteModel(model, pendingFile);
    await ref
        .read(repositoryProvider.notifier)
        .writeModel(model, completedFile);
  }

  @override
  void build() {}
}
