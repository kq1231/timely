import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/list_struct/repositories/repo.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';

final tab10RepositoryProvider =
    NotifierProvider<ListStructRepositoryNotifier<Tab10Model>, void>(
        ListStructRepositoryNotifier.new);
