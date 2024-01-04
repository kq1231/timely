import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/common/list_struct/services/repo_service.dart';
import 'package:timely/modules/tab_8/models/tab_8_model.dart';

final tab8RepositoryServiceProvider =
    NotifierProvider<ListStructRepositoryService<Tab8Model>, void>(
        ListStructRepositoryService.new);
