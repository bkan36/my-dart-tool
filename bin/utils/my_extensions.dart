extension PascalCase on String {
  String toPascalCase() => this[0].toUpperCase() + substring(1);
}