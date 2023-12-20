import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/modules/common/notifiers/services/repo_service.dart';
import 'package:timely/modules/tab_11/models/tab_11_model.dart';

final repositoryServiceProvider =
    NotifierProvider<RepositoryService<Tab11Model>, void>(
        RepositoryService.new);
