import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2/models/tab_2_model.dart';
import 'package:timely/modules/tab_2/repositories/tab_2_repo.dart';

final tab2OutputProvider =
    FutureProvider<Map<String, List<Tab2Model>>>((ref) async {
  // Fetch the models from the db
  List<Tab2Model> models =
      await ref.read(tab2RepositoryProvider.notifier).fetchTab2Models();

  //  Fetch the unique dates
  List dates = models
      .map((model) => model.startDate.toString().substring(0, 10))
      .toSet()
      .toList();

  // Create dates as keys and empty lists as values
  Map<String, List<Tab2Model>> result = {};
  for (String date in dates) {
    result[date] = [];
  }

  // Add the models to the created lists
  for (Tab2Model model in models) {
    result[model.startDate.toString().substring(0, 10)]!.add(model);
  }

  return result;
});
