import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) exit(1);

  final fileName = '${args[0]}';
  var ext = 'dart';

  if (args.length > 1 && ext != args[1]) ext = args[1];

  final file = '$fileName.$ext';

  var className = fileName.toCamelCase();

  File(file).createSync();

  File(file).writeAsStringSync('''
class $className {
  static final $className _singleton =
    $className._privateConstructor();
  factory $className() => _singleton;
  $className._privateConstructor();
}
''');
  exit(0);
}

extension CamelCase on String {
  String toCamelCase() => this[0].toUpperCase() + substring(1);
}
