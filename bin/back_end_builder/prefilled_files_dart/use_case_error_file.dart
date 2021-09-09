String dartUseCaseErrorFile() => '''
abstract class UseCaseError {
  final String message;
  final int code;

  UseCaseError(this.message, this.code);
}
''';
