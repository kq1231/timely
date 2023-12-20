import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/notifiers/repositories/pending_repo.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';

final pendingRepositoryProvider =
    NotifierProvider<PendingRepositoryNotifier<Tab10Model>, AsyncValue<void>>(
        PendingRepositoryNotifier.new);
