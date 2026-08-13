class NoInternetException implements Exception {
  final String message = 'No internet connection. Please check your network.';
}

class ServerException implements Exception {
  final String message = 'Something went wrong on the server. Please try again.';
}

class NotFoundException implements Exception {
  final String message = 'The requested content was not found.';
}

class UnknownException implements Exception {
  final String message = 'An unexpected error occurred.';
}