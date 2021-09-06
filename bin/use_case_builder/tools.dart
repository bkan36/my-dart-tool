import '../utils/exports_utils.dart';

String requestFile(String str, String entity) {
  final name = str.toPascalCase();
  final import = entity.isEmpty
      ? ''
      : 'import { ${entity.toPascalCase()} } from "src/core/entities";';

  return '''
$import

type ${name}ReqDTO = $entity;

export default ${name}ReqDTO;
''';
}

String responseFile(String str, String entity) {
  final name = str.toPascalCase();
  final entityLC = entity.toLowerCase();
  final entityPC = entity.toPascalCase();

  return '''
import { Result } from "src/core/definition";
import ${entityPC}InvalidReq from "../error/$entityLC.invalid-request";

type ${name}ResDTO = Result<$entityPC, ${entityPC}InvalidReq>;

export default ${name}ResDTO;
''';
}

String useCaseFile(String str, String entity) {
  final name = str.toPascalCase();
  final entityLC = entity.toLowerCase();
  final entityPC = entity.toPascalCase();

  return '''
import { Result, UseCase } from "src/core/definition/index";
import ${entityPC}Gateway from "src/core/gateway/$entityLC.gateway";
import ${name}ResDTO from "./$str.response-dto";
import ${name}ReqDTO from "./$str.request-dto";

export default class ${name}UC implements UseCase<${name}ReqDTO, ${name}ResDTO> {

    constructor(private ${entityLC}RG: ${entityPC}Gateway) { }

    async execute(req: ${name}ReqDTO): Promise<${name}ResDTO> {
        return;
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

String testFile(String nameFile) => '''
describe('${nameFile.splitByMaj().toLowerCase()} tests', () => {

  beforeAll(() => {

  })

  beforeEach(async () => {

  });

  it('', async () => {});

})
''';

const filesNameMap = {
  'request-dto': requestFile,
  'response-dto': responseFile,
  'use-case': useCaseFile,
  'index': index
};

const suffixFileName = ['request-dto', 'response-dto', 'use-case', 'index'];
