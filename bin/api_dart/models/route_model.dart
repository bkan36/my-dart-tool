import '../../utils/my_extensions.dart';

String routeModel(String name) {
  final nameToLowerCase = name.toLowerCase();
  final nameToPascalCase = name.toPascalCase();

  return '''
import 'package:alfred/alfred.dart';

import '../controllers/${nameToLowerCase}_controller.dart';

final ${nameToLowerCase}Controller = ${nameToPascalCase}Controller();

${nameToLowerCase}Routes(Alfred app) {
  // Add $nameToLowerCase
  app.post('/$nameToLowerCase',
      (req, res) async => ${nameToLowerCase}Controller.new$nameToPascalCase(await req.bodyAsJsonMap),
      middleware: [],
      );

  // Edit $nameToLowerCase
  app.put(
      '/$nameToLowerCase',
      (req, res) async => ${nameToLowerCase}Controller.edit$nameToPascalCase(
            req.uri.queryParameters['id'],
            await req.bodyAsJsonMap,
          ),);

  // FindOne $nameToLowerCase
  app.get('/$nameToLowerCase',
      (req, res) => ${nameToLowerCase}Controller.getOne(req.uri.queryParameters['id']));

  // FindAll $nameToLowerCase
  app.get('/${nameToLowerCase}s', (req, res) => ${nameToLowerCase}Controller.getAll(),);

  // Delete $nameToLowerCase
  app.delete('/$nameToLowerCase',
      (req, res) => ${nameToLowerCase}Controller.delete(req.uri.queryParameters['id']),);
}
''';
}
