import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_4/repositories/tab_4_repo.dart';

final tab4OutputProvider = FutureProvider<List<Tab3Model>>((ref) async {
  var res = await ref.read(tab4RepositoryProvider.notifier).fetchTab4Models();
  return res;
});
