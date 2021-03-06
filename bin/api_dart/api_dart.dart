import 'dart:io';

import 'models/controller_model.dart';
import 'models/gateway_model.dart';
import 'models/repository_model.dart';
import 'models/route_model.dart';

const paths = {
  'controllers': 'controller',
  'database/repositories': 'repository',
  'routes': 'routes',
};

const models = {
  'controller': controllerModel,
  'repository': repositoryModel,
  'routes': routeModel,
};

void main(List<String> args) {
  if (args.isEmpty) exit(1);
  final fileName = args[0];

  try {
    paths.forEach((path, name) => File(
        '$path/${fileName.toLowerCase()}_$name.dart')
      ..createSync()
      ..writeAsStringSync(models[name]!.call(fileName), mode: FileMode.append));

    File('core/gateway/${fileName}_gateway.dart')
      ..createSync()
      ..writeAsStringSync(gatewayModel(fileName));
  } catch (e) {
    throw Exception(e);
  }
}
