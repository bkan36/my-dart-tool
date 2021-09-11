import '../utils/exports_utils.dart';

String useCaseFile(String str, String entity) {
  final name = str.toPascalCase();
  final entityPC = entity.toPascalCase();
  final entityLC = entity.toLowerCase();
  
  return '''
import 'package:admin/core/definition/exports.dart';
import 'package:admin/core/definition/use_case.dart';
import 'package:admin/core/entities/$entityLC.dart';
import 'package:admin/core/gateway/${entityLC}_gateway.dart';

class ${name}UC implements UseCase<${name}Req, Result> {

    ${name}UC(${entityPC}Gateway ${entity.toLowerCase()}RG);

    Future<Result> call(${name}Req payload) async {
        return;
    }
}
''';
}