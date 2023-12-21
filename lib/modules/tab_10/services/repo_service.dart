import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/notifiers/services/repo_service.dart';
import 'package:timely/modules/tab_10/models/tab_10_model.dart';

final tab10RepositoryServiceProvider =
    NotifierProvider<RepositoryService<Tab10Model>, void>(
        RepositoryService.new);
