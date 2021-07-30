import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) exit(1);
  
  final env = Platform.environment;
  final absolutePath = '${env['PWD']}/${args[0]}';
  var ext = 'dart';
  
  if (args.length > 1 && ext != args[1]) ext = args[1];
  
  final nameDir = Uri.parse(args[0]).pathSegments.first;

  Directory(nameDir).createSync();
  
  const mvp = [
    '_controller',
    '_presenter',
    '_view',
  ];

  // ignore: curly_braces_in_flow_control_structures
  for (var fn in mvp ) File('$absolutePath/$nameDir$fn.$ext').createSync();
  exit(0);
}