import 'package:timely/modules/tab_3/models/tab_3_model.dart';

abstract class Tab3RepositorySkeleton {
  // Methods
  Future<Map<String, List<Tab3Model>>> fetchTab3Models() async {
    return {};
  }

  Future<void> writeTab3Model(Tab3Model model) async {}
}
