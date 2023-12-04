import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_5/repositories/tab_5_repo.dart';

final tab5FutureProvider = FutureProvider<List>((ref) async {
  var res = await ref.read(tab5RepositoryProvider.notifier).fetchSPWModels();
  return res;
});
