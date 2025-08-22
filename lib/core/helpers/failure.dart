class Failure implements Exception {
  final String errMessage;

  Failure({required this.errMessage});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          errMessage == other.errMessage;

  @override
  int get hashCode => errMessage.hashCode;
}
