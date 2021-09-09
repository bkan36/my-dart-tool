import '../utils/exports_utils.dart';

String useCaseFile(String str, String entity) {
  final name = str.toPascalCase();
  final entityPC = entity.toPascalCase();
  final entityLC = entity.toLowerCase();
  return '''
import '../../../definition/use_case.dart';
import '../../../entities/$entityLC.dart';
import '../../../gateway/${entityLC}_gateway.dart';

class ${name}UC implements UseCase<$entityPC, response> {

    ${name}UC(${entityPC}Gateway ${entity.toLowerCase()}RG);

    Future<response> call($entity payload) async {
        return;
    }
}
''';
}