import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/other_modules/tab_one/models/fms_model.dart';
import 'package:timely/other_modules/tab_one/repositories/tab_one_repo.dart';

final tabOneFutureProvider = FutureProvider<List<FMSModel>>((ref) async {
  var res = await ref.read(tabOneRepositoryProvider.notifier).fetchFMSModels();
  return res;
});