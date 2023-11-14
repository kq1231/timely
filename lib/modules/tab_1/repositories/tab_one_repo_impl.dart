import 'package:timely/modules/tab_1/models/fms_model.dart';

abstract class TabOneRepositorySkeleton {
  // Methods
  Future<List<FMSModel>> fetchFMSModels() async {
    return [];
  }

  Future<void> writeFMSModel(FMSModel model) async {}

  Future<void> createDefaultEntry() async {}

  Future<void> updateNextUpdateTime() async {}
}