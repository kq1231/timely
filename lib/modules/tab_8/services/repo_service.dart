import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/notifiers/list_struct/services/repo_service.dart';
import 'package:timely/modules/tab_8/models/tab_8_model.dart';

final tab8RepositoryServiceProvider =
    NotifierProvider<RepositoryService<Tab8Model>, void>(RepositoryService.new);
