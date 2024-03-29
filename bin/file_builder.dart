import 'dart:io';
import 'utils/exports_utils.dart';

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

    nameDir.split('_').forEach((n) => className += n.toPascalCase());
    className += fn.substring(1).toPascalCase();

    switch (fn) {
      case '_view':
        File(pathFile).writeAsStringSync('''
final ${className.pascalCaseToCamelCase()} = $className();

class $className {
  static final $className _singleton = $className._privateConstructor();
  factory $className() => _singleton;
  $className._privateConstructor();
}
''');
      case '_controller':
        File(pathFile).writeAsStringSync('''
final ${className.pascalCaseToCamelCase().replaceFirst('Controller', 'Ctrler')} = $className();

class $className {
  static final $className _singleton = $className._privateConstructor();
  factory $className() => _singleton;
  $className._privateConstructor();
}
''');
      default:
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

//     if (fn != '_view') {
//       File(pathFile).writeAsStringSync('''
// final ${className.pascalCaseToCamelCase()} = $className();

// class $className {
//   static final $className _singleton = $className._privateConstructor();
//   factory $className() => _singleton;
//   $className._privateConstructor();
// }
// ''');
//     } else {
//       File(pathFile).writeAsStringSync('''
// import 'package:flutter/material.dart';

// class $className extends StatelessWidget {
//   const $className({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//         ''');
//     }
  });
  exit(0);
}
