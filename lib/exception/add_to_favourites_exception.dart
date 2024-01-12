class AddToFavouritesException implements Exception {
  AddToFavouritesException(
      {this.message, required String? code, this.stackTrace})
      : code = code ?? 'unknown';

  String? message;

  String code;

  final StackTrace? stackTrace;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddToFavouritesException) return false;
    return other.hashCode == hashCode;
  }

  @override
  int get hashCode => Object.hash(code, message);

  @override
  String toString() {
    String output = 'code: $code\nmessage: $message';

    if (stackTrace != null) {
      output += '\n\n$stackTrace';
    }

    return output;
  }
}
