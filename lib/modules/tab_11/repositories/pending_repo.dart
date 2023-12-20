import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/notifiers/repositories/pending_repo.dart';
import 'package:timely/modules/tab_11/models/tab_11_model.dart';

final pendingRepositoryProvider =
    NotifierProvider<PendingRepositoryNotifier<Tab11Model>, AsyncValue<void>>(
        PendingRepositoryNotifier.new);
