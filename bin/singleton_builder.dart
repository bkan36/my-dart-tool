import 'dart:io';
import 'utils/exports_utils.dart';

void main(List<String> args) {
  if (args.isEmpty) exit(1);

  final fileName = '${args[0]}';
  var ext = 'dart';

  if (args.length > 1 && ext != args[1]) ext = args[1];

  final file = '$fileName.$ext';

  var className = fileName.snakeCaseToPascalCase();

  File(file)
    ..createSync()
    ..writeAsStringSync('''
final ${className.pascalCaseToCamelCase()} = $className();

class $className {
  $className._privateConstructor();
  factory $className() => _singleton;
  static final $className _singleton = $className._privateConstructor();
}
''');
  exit(0);
}
