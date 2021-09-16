// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'tools.dart';

String dartTestFile(String entity) => '''
import 'package:test/test.dart';

void main() {
  group('$entity test', () {

    setUpAll(() {

    });
  
    test('first test', () async {

    });
  
  });
}
''';

const fileMap = {
  '_dto': dtoFile,
  '_usecase': useCaseFile,
  'exports': dartExportsFile
};

const suffixFileName = ['_dto', '_usecase', 'exports'];

void buildUseCaseFiles(String folderName, String entityName) {
  // final pathTestFile =
  //     '../../test/${entityName.toLowerCase()}/${folderName}_test.dart';

  Directory(folderName).createSync();

  for (var f in suffixFileName) {
    final fileName = f == 'exports' ? '$f.dart' : '$folderName$f.dart';

    File('$folderName/$fileName')
      ..createSync()
      ..writeAsStringSync(fileMap[f]!.call(folderName, entityName),
          mode: FileMode.append);
  }

  // if (!File(pathTestFile).existsSync())
  //   File(pathTestFile)
  //     ..createSync()
  //     ..writeAsStringSync(dartTestFile(entityName.toLowerCase()),
  //         mode: FileMode.append);
}

void main(List<String> args) {
  if (args.isEmpty) exit(1);
  var entityName = '';

  final name = args[0];

  if (args.length == 2) entityName = args[1];

  buildUseCaseFiles(name, entityName);

  exit(0);
}
