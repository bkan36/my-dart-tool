extension MyExtension on String {
  String toPascalCase() => this[0].toUpperCase() + substring(1);
  String splitByMaj() => split(RegExp(r'(?=(?!^)[A-Z])')).join(' ');
  String snakeCaseToPascalCase() =>
      splitByMaj().split('_').map((e) => e = e.toPascalCase()).join();
  String snakeCaseToCamelCase() =>
      snakeCaseToPascalCase().replaceRange(0, 1, this[0]);
  String pascalCaseToCamelCase() => replaceRange(0, 1, this[0].toLowerCase());
}
