import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timely/modules/tab_3/models/tab_3_model.dart';
import 'package:timely/modules/tab_3/repositories/tab_3_repo.dart';

final tab3OutputProvider =
    FutureProvider<Map<String, List<Tab3Model>>>((ref) async {
  Map<String, List<Tab3Model>> res =
      await ref.read(tab3RepositoryProvider.notifier).fetchTab3Models();
  Map<String, List<Tab3Model>> objs = {};

  // Add today's date's data
  for (String date in res.keys) {
    if (date == DateFormat("yyyy-MM-dd").format(DateTime.now())) {
      objs = {date: res[date]!, ...objs};
      res.remove(date);
      break;
    }
  }

  // Add future dates and exclude any past dates
  for (String date in res.keys.toList()..sort()) {
    if (!DateTime.parse(date).isBefore(DateTime.now())) {
      objs[date] = res[date]!;
    }
  }

  return objs;
});
