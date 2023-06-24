import 'dart:io';

const foldersName = [
  'presentation',
  'presentation/widgets',
  'presentation/widgets/custom',
  'presentation/core',
  'presentation/features',
  'data',
  'data/models',
  'data/services',
  'data/utils',
];

const filesName = [
  'presentation/presentation.dart',
  'data/data.dart',
];

void main(List<String> args) {
  foldersName.forEach((folder) => Directory(folder).createSync());
  filesName.forEach((file) => File(file).createSync());
  exit(0);
}
