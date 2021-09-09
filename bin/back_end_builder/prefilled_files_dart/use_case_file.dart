String dartUseCaseFile() => '''
abstract class UseCase<I, O> {
 Future<O> call(I payload);
}
''';
