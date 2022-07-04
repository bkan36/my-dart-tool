import '../../utils/my_extensions.dart';

String controllerModel(String name) {
  final nameToPascalCase = name.toPascalCase();
  final nameToLowerCase = name.toLowerCase();

  return '''
import 'package:alfred/alfred.dart';

import 'package:bb_admin_alfred/db/repositories/${nameToLowerCase}_repository.dart';

typedef FutureMap = Future<Map<String, Object?>>;
typedef FutureListMap = Future<List<Map<String, Object?>>>;

class ${nameToPascalCase}Controller {
  ${nameToPascalCase}Controller._privateConstructor() {
    this.${nameToLowerCase}Repository = ${nameToPascalCase}Repository();
  }
  factory ${nameToPascalCase}Controller() => _singleton;
  static final ${nameToPascalCase}Controller _singleton = ${nameToPascalCase}Controller._privateConstructor();

  late final ${nameToPascalCase}Repository ${nameToLowerCase}Repository;

  FutureMap getOne(id) async => {
        '$nameToLowerCase': await this
            .${nameToLowerCase}Repository
            .getOne(id)
            .catchError((err) => throw AlfredException(404, err))
      };

  FutureMap new$nameToPascalCase(create${nameToPascalCase}Dto) async {
    return {'${nameToLowerCase}Id': await this.${nameToLowerCase}Repository.save(create${nameToPascalCase}Dto['$nameToLowerCase'])};
  }

  FutureMap edit$nameToPascalCase(String? id, edit${nameToPascalCase}Dto) async {
    return await this
        .${nameToLowerCase}Repository
        .update(id ?? '', edit${nameToPascalCase}Dto['$nameToLowerCase'])
        .then(($nameToLowerCase) => {'$nameToLowerCase': $nameToLowerCase, 'message': '$nameToLowerCase successfuly edited'});
  }

  FutureListMap getAll() async => await this.${nameToLowerCase}Repository.getAll();

  FutureMap delete(String? id) async =>
      {'deletionState': await this.${nameToLowerCase}Repository.delete(id ?? '')};
}
''';
}
