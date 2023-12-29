import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/notifiers/list_struct/services/repo_service.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';

final tab10RepositoryServiceProvider =
    NotifierProvider<RepositoryService<Tab10Model>, void>(
        RepositoryService.new);
