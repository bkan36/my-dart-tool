import '../../utils/exports_utils.dart';

String gatewayModel(String name) => '''
abstract class ${name.toPascalCase()}Gateway {
  Future<String?>? save(Map<String, dynamic> new${name.toPascalCase()});
  Future<Map<String, dynamic>?> update(String id, Map<String, dynamic> ${name.toLowerCase()});
  Future<Map<String, dynamic>?> getOne(String id);
  Future<bool> delete(String id);
}
''';
