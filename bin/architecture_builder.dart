import 'dart:io';

const foldersName = [
  'presentation',
  'presentation/widgets',
  'presentation/widgets/custom',
  'presentation/core',
  'presentation/features',
  'domain',
  'domain/definition',
  'domain/gateway',
  'domain/use-cases',
  'data',
  'data/models',
  'data/config',
  'data/repositories',
  'data/repositories/remote',
  'data/repositories/local',
];

const filesName = [
  'presentation/presentation.dart',
  'data/data.dart',
  'domain/domain.dart',
];

void main(List<String> args) {
  foldersName.forEach((folder) => Directory(folder).createSync());
  filesName.forEach((file) => File(file).createSync());
  exit(0);
}
