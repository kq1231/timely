import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_2_6_7/models/tab_2_model.dart';
import 'package:timely/modules/tab_2_6_7/repositories/repo.dart';
import 'package:timely/reusables.dart';

final tab6OutputProvider = FutureProvider<Map>((ref) async {
  final file = (await ref.read(dbFilesProvider.future)).tab6File;

  await ref
      .read(tab2RepositoryProvider.notifier)
      .generateActivitiesForToday(file);

  // Fetch the models from the db
  List<Tab2Model> models = await ref
      .read(tab2RepositoryProvider.notifier)
      .fetchTab2ModelsForToday(file);

  return {"models": models, "file": file};
});
