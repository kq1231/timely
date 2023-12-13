import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_8/models/tab_8_model.dart';
import 'package:timely/modules/tab_8/repositories/tab_8_repo.dart';

final tab8OutputProvider = FutureProvider<List<Tab8Model>>((ref) async {
  var res =
      await ref.read(tab8RepositoryProvider.notifier).fetchAllTab8Models();
  return res;
});
