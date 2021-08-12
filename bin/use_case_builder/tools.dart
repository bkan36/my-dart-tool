import '../utils/exports_utils.dart';

String requestFile(String str, String? entity) {
  final name = str.toPascalCase();

  return '''
type ${name}ReqDTO = <toFill>;

export default ${name}ReqDTO;
''';
}

String responseFile(String str, String entity) {
  final name = str.toPascalCase();
  final entityCC = entity.toPascalCase();

  return '''
type ${name}ResDTO = Result<$entityCC, ${entityCC}InvalidReq>;

export default ${name}ResDTO;
''';
}

String useCaseFile(String str, String entity) {
  final name = str.toPascalCase();
  final entityLC = entity.toLowerCase();
  final entityCC = entity.toPascalCase();

  return '''
import { Result, UseCase } from "src/core/definition/index";
import ${name}ResDTO from "./$str.response-dto";

export default class ${name}UC implements UseCase<$entityCC, ${name}ResDTO> {

    constructor(private ${entityLC}RG: ${entityCC}Gateway) { }

    async execute(req: $entityCC): Promise<${name}ResDTO> {
        const result = await this.${entityLC}RG...;

        return Result.ok<$entityCC>(result);
    }
}
''';
}

String index(String str, String? entity) {
  final name = str.toPascalCase();

  return '''
export { default as ${name}UC } from "./$str.use-case";
export { default as ${name}ReqDTO } from "./$str.request-dto";
export { default as ${name}ResDTO } from "./$str.response-dto";
''';
}

const filesNameMap = {
  'request-dto': requestFile,
  'response-dto': responseFile,
  'use-case': useCaseFile,
  'index': index
};

const suffixFileName = ['request-dto', 'response-dto', 'use-case', 'index'];
