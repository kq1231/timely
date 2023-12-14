import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';
import 'package:timely/modules/tab_10/repositories/pending_repo.dart';

final tab10OutputProvider = FutureProvider<List<Tab10Model>>((ref) async {
  List<Tab10Model> res = await ref
      .read(tab10PendingRepositoryProvider.notifier)
      .fetchTab10Models();

  return res;
});
