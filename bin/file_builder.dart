import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) exit(1);
  
  final relativePath = '${args[0]}';
  var ext = 'dart';

  if (args.length > 1 && ext != args[1]) ext = args[1];

  final nameDir = Uri.parse(args[0]).pathSegments.first;

  Directory(nameDir).createSync();

  const mvp = [
    '_controller',
    '_presenter',
    '_view',
  ];

  mvp.forEach((fn) {
    var pathFile = '$relativePath/$nameDir$fn.$ext';
    var className = '';

    File(pathFile).createSync();

    nameDir.split('_').forEach((n) => className += n.toCamelCase());
    className += fn.substring(1).toCamelCase();

    if (fn != '_view') {
      File(pathFile).writeAsStringSync('''
class $className {
  static final $className _singleton =
    $className._privateConstructor();
  factory $className() => _singleton;
  $className._privateConstructor();
}
''');
    } else {
      File(pathFile).writeAsStringSync('''
import 'package:flutter/material.dart';

class $className extends StatelessWidget {
  const $className({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
        ''');
    }
  });
  exit(0);
}

extension CamelCase on String {
  String toCamelCase() => this[0].toUpperCase() + substring(1);
}
