import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timely/reusables.dart';

final tab4Top5Provider = FutureProvider.autoDispose<List>((ref) async {
  // Get the file
  File file = (await ref.read(dbFilesProvider.future)).tabFourFile;

  // Extract the json
  List content = jsonDecode(await file.readAsString());

  // Create an empty list
  List top5 = [];

  if (content.length >= 5) {
    List.generate(5, (index) {
      top5.add([content[index]["Priority"], content[index]["Activity"]]);
    });
  } else {
    List.generate(content.length, (index) {
      top5.add([content[index]["Priority"], content[index]["Activity"]]);
    });
  }

  return top5;
});
