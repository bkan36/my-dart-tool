extension CamelCase on String {
  String toCamelCase() => this[0].toUpperCase() + substring(1);
}