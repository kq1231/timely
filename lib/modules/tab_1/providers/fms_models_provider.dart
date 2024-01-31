import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1/models/fms_model.dart';
import 'package:timely/modules/tab_1/repositories/repo.dart';

final fmsModelsProvider =
    FutureProvider.autoDispose<List<FMSModel>>((ref) async {
  var res = await (ref.read(tab1RepositoryProvider.notifier).fetchFMSModels());

  return res;
});
