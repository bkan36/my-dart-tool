import 'dart:io';
import 'tools.dart';

String dartTestFile(String entity) => '''
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$entity test', () {

    setUpAll(() {

    });
  
    test('first test', () async {

    });
  
  });
}
''';

void buildUseCaseFiles(String folderName, String entityName) {
  Directory(folderName).createSync();

  final fileName = '${folderName}_usecase.dart';

  File('$folderName/$fileName')
    ..createSync()
    ..writeAsStringSync(useCaseFile(folderName, entityName),
        mode: FileMode.append);

  File('../../test/${entityName.toLowerCase()}/${folderName}_test.dart')
    ..createSync()
    ..writeAsStringSync(dartTestFile(entityName.toLowerCase()));
}

void main(List<String> args) {
  if (args.isEmpty) exit(1);
  var entityName = '';

  final name = args[0];

  if (args.length == 2) entityName = args[1];

  buildUseCaseFiles(name, entityName);

  exit(0);
}
