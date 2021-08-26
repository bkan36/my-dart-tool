import 'dart:io';

import 'prefilled_files/index_definition.dart';
import 'prefilled_files/jest_unit.dart';
import 'prefilled_files/result.dart';
import 'prefilled_files/use_case.dart';
import 'prefilled_files/use_case_error.dart';
import 'prefilled_files/use_case_error_res.dart';

const foldersName = [
  'core',
  'core/definition',
  'core/entities',
  'core/test',
  'core/mock',
  'core/gateway',
  'core/use-cases',
  'core/erros',
];

const filesName = [
  'core/index.ts',
  'core/entities/index.ts',
  'core/test/index.ts',
  'core/mock/index.ts',
  'core/gateway/index.ts',
  'core/use-cases/index.ts',
  'core/erros/index.ts',
];

const definitionFiles = {
  'result': resultFile,
  'useCase': useCaseFile,
  'useCaseError': useCaseErrorFile,
  'useCaseErrorRes': useCaseErrorResFile,
  'index': indexDefinition
};
void main(List<String> args) {
  foldersName.forEach((folder) => Directory(folder).createSync());
  filesName.forEach((file) => File(file).createSync());
  definitionFiles.forEach((fileName, data) {
    File('core/definition/$fileName.ts')
      ..createSync(recursive: true)
      ..writeAsStringSync(data.call(), mode: FileMode.append);
  });

  File('core/test/jest-unit.json')
    ..createSync(recursive: true)
    ..writeAsStringSync(jestUnitfile());
  exit(0);
}
