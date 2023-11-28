import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2/models/tab_2_model.dart';
import 'package:timely/modules/tab_2/repositories/tab_2_repo.dart';

final tab2OutputProvider = FutureProvider<List<Tab2Model>>((ref) async {
  // Fetch the models from the db
  List<Tab2Model> models =
      await ref.read(tab2RepositoryProvider.notifier).fetchTab2ModelsForToday();

  return models;
});
