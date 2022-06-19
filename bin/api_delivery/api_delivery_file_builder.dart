import 'dart:io';
import '../utils/my_extensions.dart';

const folders = ['controller', 'interface', 'module', 'service'];

String controllerModel(String name) {
  final nameToPascalCase = name.toPascalCase();
  final nameToLowerCase = name.toLowerCase();

  return '''
import { Body, Controller, Delete, Param, Post, Put } from "@nestjs/common"

import { ${nameToPascalCase}Service } from "../services/$nameToLowerCase.service"

import { Create${nameToPascalCase}Dto } from "../services/dto/$nameToLowerCase/create$nameToPascalCase.dto"
import { Update${nameToPascalCase}Dto } from "../services/dto/$nameToLowerCase/update$nameToPascalCase.dto"

import { COLON_ID, ID } from "src/utils/constants"

@Controller("/${nameToLowerCase}s")
export class ${nameToPascalCase}Controller {

  // ------------------------------------------
  // INIT
  // ------------------------------------------

  constructor(private readonly ${nameToLowerCase}Service: ${nameToPascalCase}Service) {}

  // ------------------------------------------
  // PERSISTENCES
  // ------------------------------------------

  @Post()
  create(@Body() create${nameToPascalCase}Dto: Create${nameToPascalCase}Dto) {
    return this.${nameToLowerCase}Service.create(create${nameToPascalCase}Dto)
  }

  @Put(COLON_ID)
  update(@Param(ID) id: string, @Body() update${nameToPascalCase}Dto: Update${nameToPascalCase}Dto) {
    return this.${nameToLowerCase}Service.update(id, update${nameToPascalCase}Dto)
  }

  @Delete(COLON_ID)
  remove(@Param(ID) id: string) {
    return this.${nameToLowerCase}Service.delete(id)
  }
}
''';
}

String interfaceModel(String name) => '''
import { Document } from 'mongoose'

export interface ${name.toPascalCase()} extends Document {

}
''';

String moduleModel(String name) => '''
import { Module } from '@nestjs/common'

import { ${name.toPascalCase()}Controller } from '../controllers/${name.toLowerCase()}.controller'

import { ${name.toPascalCase()}Service } from '../services/${name.toLowerCase()}.service'


@Module({
  controllers: [${name.toPascalCase()}Controller],
  providers: [${name.toPascalCase()}Service]
})
export class ${name.toPascalCase()}Module { }
''';

String serviceModel(String name) {
  final nameToPascalCase = name.toPascalCase();
  final nameToLowerCase = name.toLowerCase();

  return '''
import { Inject, Injectable } from '@nestjs/common'

import { Create${nameToPascalCase}Dto } from './dto/$nameToLowerCase/create$nameToPascalCase.dto'
import { Update${nameToPascalCase}Dto } from './dto/$nameToLowerCase/update$nameToPascalCase.dto'

import { $nameToPascalCase } from '../interfaces/$nameToLowerCase.interface'

import { ADDRESS_MODEL } from '../utils/constants'

import { Model } from 'mongoose'

@Injectable()
export class ${nameToPascalCase}Service {

  // ------------------------------------------
  // INIT
  // ------------------------------------------

  constructor(@Inject(${name.toUpperCase()}_MODEL) private ${nameToLowerCase}Model: Model<$nameToPascalCase>) {}

  // ------------------------------------------
  // PERSISTENCES
  // ------------------------------------------

  create(create${nameToPascalCase}Dto: Create${nameToPascalCase}Dto): Promise<$nameToPascalCase> {
    return this.${nameToLowerCase}Model.create(create${nameToPascalCase}Dto)
  }

  update(_id: String, update${nameToPascalCase}Dto: Update${nameToPascalCase}Dto) {
    return this.${nameToLowerCase}Model.findOneAndUpdate({ _id }, update${nameToPascalCase}Dto, {
      new: true,
    })
  }

  delete(_id: string) {
    return this.${nameToLowerCase}Model.findOneAndDelete({ _id })
  }
}
''';
}

String schemaModel(String name) => '''
import { Schema } from 'mongoose'

// ------------------------------------------
// INIT  
// ------------------------------------------

export const ${name.toPascalCase()}Schema = new Schema({
    _id: { type: Schema.Types.ObjectId, auto: true },
})
''';

String createDtoModel(String name) => '''
export class Create${name.toPascalCase()}Dto {

}
''';

String updateDtoModel(String name) => '''
import { PartialType } from '@nestjs/mapped-types'

import { Create${name.toPascalCase()}Dto } from './create${name.toPascalCase()}.dto'

export class Update${name.toPascalCase()}Dto extends PartialType(Create${name.toPascalCase()}Dto) {}
''';

const preFilledFiles = {
  'controller': controllerModel,
  'interface': interfaceModel,
  'module': moduleModel,
  'service': serviceModel,
  'schema': schemaModel,
  'createDto': createDtoModel,
  'updateDto': updateDtoModel,
};

void main(List<String> args) {
  if (args.isEmpty) exit(1);
  final fileName = args[0];

  try {
    folders.forEach((folderName) =>
        File('${folderName}s/$fileName.$folderName.ts')
          ..createSync(recursive: true)
          ..writeAsStringSync(preFilledFiles[folderName]!.call(fileName),
              mode: FileMode.append));

    File('services/schemas/$fileName.schema.ts')
      ..createSync()
      ..writeAsStringSync(preFilledFiles['schema']!.call(fileName),
          mode: FileMode.append);

    Directory('services/dto/$fileName').createSync();

    File('services/dto/$fileName/create${fileName.toPascalCase()}.dto.ts')
      ..createSync()
      ..writeAsStringSync(preFilledFiles['createDto']!.call(fileName),
          mode: FileMode.append);

    File('services/dto/$fileName/update${fileName.toPascalCase()}.dto.ts')
      ..createSync()
      ..writeAsStringSync(preFilledFiles['updateDto']!.call(fileName),
          mode: FileMode.append);

    final newConstant =
        '\nexport const ${fileName.toUpperCase()}_MODEL = \'${fileName.toUpperCase()}_MODEL\'\n\n';

    final buffer = File('utils/constants.ts').readAsStringSync();

    int lastIdx;

    // constant.ts

    lastIdx = buffer.lastIndexOf('MODEL\'');

    final newBuffer = buffer.replaceRange(lastIdx + 'MODEL\''.length,
        lastIdx + 'MODEL\''.length + 1, newConstant);

    File('utils/constants.ts').writeAsStringSync(newBuffer);

    // app.module.ts

    final addModuleImport = '\n${fileName.toPascalCase()}Module,\n';

    final appModuleBuffer = File('app.module.ts').readAsStringSync();

    lastIdx = appModuleBuffer.lastIndexOf('Module,');

    final newAppModuleBuffer = appModuleBuffer.replaceRange(
        lastIdx + 'Module,'.length,
        lastIdx + 'Module,'.length + 1,
        addModuleImport);

    File('app.module.ts').writeAsStringSync(newAppModuleBuffer);
  } catch (e) {
    print(e);
  }
}
