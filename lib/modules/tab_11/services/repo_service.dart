import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/list_struct/services/repo_service.dart';
import 'package:timely/modules/tab_11/models/tab_11_model.dart';

final tab11RepositoryServiceProvider =
    NotifierProvider<ListStructRepositoryService<Tab11Model>, void>(
        ListStructRepositoryService.new);
