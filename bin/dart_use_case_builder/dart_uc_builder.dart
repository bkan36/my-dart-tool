// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'tools.dart';

String dartTestFile(String name, String entity, bool isFlutterTestFile) {
  var importPath = isFlutterTestFile
      ? 'package:flutter_test/flutter_test.dart'
      : 'package:test/test.dart';

  return '''
import $importPath;

void main() {
  group('${name.replaceAll('_', ' ')} test', () {

    setUpAll(() {

    });
  
    test('should ${name.replaceAll('_', ' ')}', () async {

    });
  
  });
}
''';
}

const fileMap = {
  '_dto': dtoFile,
  '_usecase': useCaseFile,
  'exports': dartExportsFile
};

const suffixFileName = ['_dto', '_usecase', 'exports'];

void buildUseCaseFiles(
    String folderName, String entityName, bool isFlutterTestFile) {
  final pathTestFile = isFlutterTestFile
      ? '../../../../test/unit/${entityName.toLowerCase()}/${folderName}_test.dart'
      : '../../../../test/unit/${entityName.toLowerCase()}/${folderName}_test.dart';

  Directory(folderName).createSync();

  for (var f in suffixFileName) {
    final fileName = f == 'exports' ? '$f.dart' : '$folderName$f.dart';

    File('$folderName/$fileName')
      ..createSync()
      ..writeAsStringSync(fileMap[f]!.call(folderName, entityName),
          mode: FileMode.append);
  }

  if (!File(pathTestFile).existsSync()) {
    File(pathTestFile)
      ..createSync(recursive: true)
      ..writeAsStringSync(
          dartTestFile(folderName, entityName.toLowerCase(), isFlutterTestFile),
          mode: FileMode.append);
  }
}

void main(List<String> args) {
  if (args.isEmpty) exit(1);
  var entityName = '';
  var isFlutterTestFile = false;

  final name = args[0];

  if (args.length == 3) isFlutterTestFile = true;
  if (args.length > 1) entityName = args[1];

  buildUseCaseFiles(name, entityName, isFlutterTestFile);

  exit(0);
}
