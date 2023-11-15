import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/home/providers/tab1_text1_provider.dart';
import 'package:timely/modules/home/providers/tab3_text_1_provider.dart';
import 'package:timely/modules/home/providers/tab4_top_5_provider.dart';

final tabsDataProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  var res = await Future.wait([
    ref.read(tab1Text1Provider.future),
    ref.read(tab3Text1Provider.future),
    ref.read(tab4Top5Provider.future)
  ]);

  return {"tab_1Text": res[0], "tab_3": res[1], "tab_4": res[2]};
});
