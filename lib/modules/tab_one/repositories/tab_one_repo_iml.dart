import 'package:timely/modules/tab_one/models/fms_model.dart';

abstract class TabOneRepositorySkeleton {
  // Methods
  Future<List<FMSModel>> fetchFMSModels() async {
    return [];
  }

  Future<void> writeFMSModel(FMSModel model) async {}
}
