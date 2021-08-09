String requestFile(str) {
  final name = str.toCamelCase();
  return '''
type ${name}ReqDTO = <toFill>;

export default ${name}ReqDTO;
''';
}

String responseFile(str) {
  final name = str.toCamelCase();
  return '''
type ${name}ResDTO = Result<entity, entityInvalidReq>;

export default ${name}ResDTO;
''';
}

String useCaseFile(str) {
  final name = str.toCamelCase();
  return '''
import { Result, UseCase } from "src/core/definition/index";
import ${name}ResDTO from "./$str.response-dto";

export default class ${name}UC implements UseCase<entity, ${name}ResDTO> {

    constructor(private entityRG: entityRepositoryGateway) { }

    async execute(req: entity): Promise<${name}ResDTO> {
        const result = await this.entityRG...;

        return Result.ok<entity>(result);
    }
}
''';
}

String index(String str) {
  final name = str.toCamelCase();

  return '''
export { default as ${name}UC } from "./$str.use-case";
export { default as ${name}ReqDTO } from "./$str.request-dto";
export { default as ${name}ResDTO } from "./$str.response-dto";
''';
}

extension CamelCase on String {
  String toCamelCase() => this[0].toUpperCase() + substring(1);
}

const filesMap = {
  'request-dto': requestFile,
  'response-dto': responseFile,
  'use-case': useCaseFile,
  'index': index
};

const suffixFileName = [
  'request-dto',
  'response-dto',
  'use-case',
  'index'
];
