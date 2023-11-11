import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/repositories/tab_3_repo.dart';

final tab3OutputProvider =
    FutureProvider<Map<String, List<Tab3Model>>>((ref) async {
  var res = await ref.read(tab3RepositoryProvider.notifier).fetchTab3Models();
  return res;
});
