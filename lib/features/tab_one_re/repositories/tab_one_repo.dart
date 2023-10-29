import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/features/tab_one_re/models/fms_model.dart';
import 'package:timely/features/tab_one_re/repositories/tab_one_repo_iml.dart';
import 'package:timely/public_providers.dart/db_files_provider.dart';

class TabOneRepository extends Notifier<AsyncValue<void>>
    implements TabOneRepositorySkeleton {
  @override
  build() {
    return const AsyncValue.data(null);
  }

  @override
  Future<List<FMSModel>> fetchFMSModels() async {
    final tabOneFile = (await ref.read(dbFilesProvider.future)).tabOneReFile;
    final jsonContent = jsonDecode(await tabOneFile.readAsString());
    final fmsModels = <FMSModel>[];
    for (final date in jsonContent.keys) {
      var content = jsonContent[date];
      Map json = {
        date: [
          content[0][0],
          content[0][1],
          content[0][2],
          content[1],
          content[2]
        ]
      };
      fmsModels.add(FMSModel.fromJson(json));
    }

    return fmsModels;
  }

  @override
  Future<void> writeFMSModel(FMSModel model) async {
    final tabOneFile = (await ref.read(dbFilesProvider.future)).tabOneReFile;

    final jsonContent = jsonDecode(await tabOneFile.readAsString());
    jsonContent[model.date] = [];
    jsonContent[model.date].add(
      [
        model.fScore,
        model.mScore,
        model.sScore,
      ],
    );
    jsonContent[model.date].add(
      "${model.nextUpdateTime.hour}: ${model.nextUpdateTime.minute}",
    );
    jsonContent[model.date].add(model.text_1);
    await tabOneFile.writeAsString(jsonEncode(jsonContent));
  }
}

final tabOneRepositoryProvider =
    NotifierProvider<TabOneRepository, AsyncValue<void>>(TabOneRepository.new);
