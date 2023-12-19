import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/repositories/pending_repo.dart';
import 'package:timely/modules/tab_11/models/tab_11_model.dart';
import 'package:timely/reusables.dart';

class Tab11InputNotifier extends Notifier<Tab11Model> {
  @override
  build() {
    return Tab11Model(
      item: "",
      qty: 0,
      urgent: false,
      unit: "",
    );
  }

  void setItem(String item) {
    state = state.copyWith(item: item);
  }

  void setQuantity(String qty) {
    try {
      state = state.copyWith(qty: int.parse(qty));
    } catch (e) {
      // Skip.
    }
  }

  void setUrgency(bool urgent) {
    state = state.copyWith(urgent: urgent);
  }

  void setUnit(String unit) {
    state = state.copyWith(unit: unit);
  }

  void setModel(Tab11Model model) {
    state = model;
  }

  Future<void> syncToDB() async {
    final file = (await ref.read(dbFilesProvider.future))[11]![0];
    await ref.read(pendingRepositoryProvider.notifier).writeModel(state, file);
  }
}

final tab11InputProvider = NotifierProvider<Tab11InputNotifier, Tab11Model>(() {
  return Tab11InputNotifier();
});
