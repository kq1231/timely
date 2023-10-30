import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/features/tab_one_re/models/fms_model.dart';
import 'package:timely/features/tab_one_re/repositories/tab_one_repo.dart';

final tabOneFutureProvider = FutureProvider<List<FMSModel>>((ref) async {
  var res = await ref.read(tabOneRepositoryProvider.notifier).fetchFMSModels();
  return res;
});
