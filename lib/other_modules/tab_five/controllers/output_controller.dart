import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/other_modules/tab_five/repositories/tab_five_repo.dart';

final tabFiveFutureProvider = FutureProvider<List>((ref) async {
  var res = await ref.read(tabFiveRepositoryProvider.notifier).fetchSPWModels();
  return res;
});
