import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_11/services/tab_11_service.dart';

final tab11OutputProvider = FutureProvider<List>((ref) async {
  List res = await ref.read(tab11ServiceProvider.notifier).fetchTab11Models();

  return res;
});
