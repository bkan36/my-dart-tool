import '../utils/exports_utils.dart';

String useCaseFile(String str, String entity) {
  final name = str.snakeCaseToPascalCase();
  final entityPC = entity.toPascalCase();
  final entityLC = entity.toLowerCase();

  return '''
import 'package:admin/core/definition/exports.dart';
import 'package:admin/core/definition/use_case.dart';
import 'package:admin/core/gateway/${entityLC}_gateway.dart';
import './${str}_dto.dart';

class ${name}UC implements UseCase<${name}DTO, Result> {
    final ${entityPC}Gateway _${entityLC}RG;

    ${name}UC(this._${entityLC}RG);

    @override
    Future<Result> call(${name}DTO payload) async {
        return Result.success(null);
    }
}
''';
}

String dtoFile(String str, String entity) {
  final className = str.snakeCaseToPascalCase();
  final entityLC = entity.toLowerCase();

  return '''
import 'package:admin/core/entities/$entityLC.dart';

class ${className}DTO {
  final $entity _$entityLC;

  ${className}DTO(this._$entityLC);
}
''';
}

String dartExportsFile(String str, String? entity) {
  return '''
export './${str}_dto.dart';
export './${str}_usecase.dart';
''';
}
