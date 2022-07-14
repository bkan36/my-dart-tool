import '../../utils/exports_utils.dart';

String gatewayModel(String name) => '''
abstract class ${name.toPascalCase()}Gateway {
  save(Map<String, dynamic> new${name.toPascalCase()});
  update(String id, Map<String, dynamic> ${name.toLowerCase()});
  getOne(String id);
  delete(String id);
}
''';
