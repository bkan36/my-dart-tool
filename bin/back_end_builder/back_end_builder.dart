import 'dart:io';

import 'prefilled_files/jest_unit.dart';
import 'prefilled_files/result.dart';
import 'prefilled_files/use_case.dart';
import 'prefilled_files/use_case_error.dart';
import 'prefilled_files/use_case_error_res.dart';
import 'prefilled_files_dart/exports_definition.dart';
import 'prefilled_files_dart/gateway_fill.dart';
import 'prefilled_files_dart/result_file.dart';
import 'prefilled_files_dart/use_case_error_file.dart';
import 'prefilled_files_dart/use_case_file.dart';

const foldersName = [
  'core',
  'core/definition',
  'core/entities',
  'core/test',
  'core/mock',
  'core/gateway',
  'core/use-cases',
  'core/errors',
];

const tsExportFiles = [
  'core/entities/index.ts',
  'core/mock/index.ts',
  'core/gateway/index.ts',
  'core/errors/index.ts',
];

const dartExportFiles = [
  'core/definition/exports.dart',
  'core/entities/exports.dart',
  'core/mock/exports.dart',
  'core/gateway/exports.dart',
  'core/errors/exports.dart',
];

const definitionFiles = {
  'result': resultFile,
  'useCase': useCaseFile,
  'useCaseError': useCaseErrorFile,
  'useCaseErrorRes': useCaseErrorResFile,
};

const dartDefinitionFiles = {
  'result': dartResultFile,
  'use_case': dartUseCaseFile,
  'use_case_error': dartUseCaseErrorFile,
  'gateway': dartGatewayFile,
  'exports': dartExportDefinition,
};

void main(List<String?> args) {
  var exportFileName = args.isEmpty ? tsExportFiles : dartExportFiles;
  var dfiles = args.isEmpty ? definitionFiles : dartDefinitionFiles;

  foldersName.forEach((folder) => Directory(folder).createSync());
  exportFileName.forEach((file) => File(file).createSync());

  dfiles.forEach((fileName, data) {
    File('core/definition/$fileName.${args[0] ?? 'dart'}')
      ..createSync(recursive: true)
      ..writeAsStringSync(data.call(), mode: FileMode.append);
  });

  if (args.isEmpty) {
    File('core/test/jest-unit.json')
      ..createSync(recursive: true)
      ..writeAsStringSync(jestUnitfile());
  }

  exit(0);
}
