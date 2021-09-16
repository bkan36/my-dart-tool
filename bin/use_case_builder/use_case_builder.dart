import 'dart:io';
import 'tools.dart';
import '../utils/exports_utils.dart';

void buildUseCaseFiles(String folderName, String ext, String entityName) {
  Directory(folderName).createSync();

  for (var f in suffixFileName) {
    final fileName = f == 'index' ? '$f.$ext' : '$folderName.$f.$ext';

    File('$folderName/$fileName')
      ..createSync(recursive: true)
      ..writeAsStringSync(filesNameMap[f]!.call(folderName, entityName),
          mode: FileMode.append);
  }
}

void main(List<String> args) {
  if (args.isEmpty) exit(1);
  var ext = 'ts';
  var entityName = '';

  final name = args[0];

  if (args.length == 2 && entityName != args[1]) entityName = args[1];
  if (args.length == 3 && ext != args[2]) ext = args[2];

  buildUseCaseFiles(name, ext, entityName);

  File('../../test/${args[1].toLowerCase()}/$name.spec.$ext')
    ..createSync(recursive: true)
    ..writeAsStringSync(testFile(name));

  Directory('error').createSync();

  File('error/${entityName.toLowerCase()}.invalid-request.ts')
    ..createSync()
    ..writeAsStringSync(errorFile(entityName));

  File('error/index.ts')
    ..createSync()
    ..writeAsStringSync('''
export { default as ${entityName.toPascalCase()}InvalidReq } from './${entityName.toLowerCase()}.invalid-request';
''');

  exit(0);
}
