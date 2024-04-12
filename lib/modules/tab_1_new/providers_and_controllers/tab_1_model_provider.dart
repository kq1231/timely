import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/tab_1_new/models/tab_1_model.dart';
import 'package:timely/modules/tab_1_new/repositories/tab_1_repository.dart';

class Tab1ModelNotifier extends AsyncNotifier<Tab1Model> {
  @override
  FutureOr<Tab1Model> build() async {
    return await ref.read(tab1RepositoryProviderNew.notifier).fetchModel();
  }

  // Methods
  void subtractPoints(int points) {
    state = state.requireValue.copyWith(
      totalPoints: state.requireValue.totalPoints - points,
      subtractions: state.requireValue.subtractions + points,
    ) as AsyncValue<Tab1Model>;

    ref
        .read(tab1RepositoryProviderNew.notifier)
        .writeTab1Model(state.requireValue, force: true);
  }
}

final tab1ModelProvider =
    AsyncNotifierProvider<Tab1ModelNotifier, Tab1Model>(Tab1ModelNotifier.new);
