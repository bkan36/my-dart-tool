import '../../utils/exports_utils.dart';

String repositoryModel(String name) {
  final nameToLowerCase = name.toLowerCase();
  final nameToPascalCase = name.toPascalCase();

  return '''import 'package:alfred/alfred.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'package:bb_admin_alfred/core/gateway/${nameToLowerCase}_gateway.dart';

import '../mongo_service.dart';

final adminRepo = ${nameToPascalCase}Repository();

const collectionName = '$nameToLowerCase';

class ${nameToPascalCase}Repository implements ${nameToPascalCase}Gateway {
  ${nameToPascalCase}Repository._();

  static final ${nameToPascalCase}Repository _singleton = ${nameToPascalCase}Repository._();
  factory ${nameToPascalCase}Repository() => _singleton;

  final collection = MongoService().collection(collectionName);

  Future<Map<String, dynamic>?> getOne(String id) async => await collection
      .modernFindOne(selector: where.id(ObjectId.parse(id)))
      .catchError((e) => throw AlfredException(HttpStatus.notFound, notFound('${name.toUpperCase()}')));

  @override
  Future<String?> save(Map<String, dynamic> $nameToLowerCase) => collection
      .insertOne($nameToLowerCase)
      .then((res) => res.id.toString().substring(10, 34))
      .catchError((err) => throw AlfredException(HttpStatus.internalServerError, insertionFailed('${name.toUpperCase()}')));

  @override
  Future<Map<String, dynamic>?> update(
      String id, Map<String, dynamic> $nameToLowerCase) async {
    Map<String, dynamic>? ${nameToLowerCase}ToUpdate = await getOne(id);

    if (${nameToLowerCase}ToUpdate == null) throw AlfredException(HttpStatus.notFound, notFound('${name.toUpperCase()}'));

    $nameToLowerCase.forEach((key, value) => ${nameToLowerCase}ToUpdate[key] = $nameToLowerCase[key]);

    return collection
        .modernUpdate(where.id(${nameToLowerCase}ToUpdate['_id']), ${nameToLowerCase}ToUpdate)
        .catchError(
            (err) => throw AlfredException(HttpStatus.internalServerError, updatingFailed('${name.toUpperCase()}')));
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    return await this.collection.find().toList();
  }

  @override
  Future<bool> delete(String id) async => await this
      .collection
      .deleteOne(where.id(ObjectId.parse(id)))
      .then((response) => response.nRemoved == 1 ? true : false);
}''';
}
