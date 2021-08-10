import 'dart:io';
import 'tools.dart';

void buildUseCaseFiles(String folderName, String ext, String entityName) {
  Directory(folderName).createSync();

  for (var f in suffixFileName) {
    final fileName = '$folderName.$f.$ext';

    File('$folderName/$fileName')
      ..createSync()
      ..writeAsStringSync(filesNameMap[f]!.call(folderName, entityName),
          mode: FileMode.append);
  }
}

void main(List<String> args) {
  if (args.isEmpty) exit(1);
  var ext = 'ts';
  var entityName = 'entity';

  final name = args[0];

  if (args.length == 2 && entityName != args[1]) entityName = args[1];
  if (args.length == 3 && ext != args[2]) ext = args[2];

  buildUseCaseFiles(name, ext, entityName);

  exit(0);
}
