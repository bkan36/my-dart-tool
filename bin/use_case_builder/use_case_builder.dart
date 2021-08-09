import 'dart:io';
import 'tools.dart';

void main(List<String> args) {
  if (args.isEmpty) exit(1);
  var ext = 'ts';

  final name = args[0];

  if (args.length > 1 && ext != args[1]) ext = args[1];

  Directory(name).createSync();

  for (var f in suffixFileName) {
    final fileName = '$name.$f.$ext';

    File('$name/$fileName')
      ..createSync()
      ..writeAsStringSync(filesMap[f]!.call(name), mode: FileMode.append);
  }

  exit(0);
}