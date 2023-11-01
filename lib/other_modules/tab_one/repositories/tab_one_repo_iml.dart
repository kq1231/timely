import 'package:timely/other_modules/tab_one/models/fms_model.dart';

abstract class TabOneRepositorySkeleton {
  // Methods
  Future<List<FMSModel>> fetchFMSModels() async {
    return [];
  }

  Future<void> writeFMSModel(FMSModel model) async {}

  Future<void> createDefaultEntry() async {}

  Future<void> updateNextUpdateTime() async {}
}
