/// API Response wrapper
class ApiResponse<T> {
  final T? data;
  final bool isLoading;
  final String? errorMessage;

  const ApiResponse._({
    this.data,
    this.isLoading = false,
    this.errorMessage,
  });

  factory ApiResponse.data(T data) => ApiResponse._(data: data);
  factory ApiResponse.loading() => const ApiResponse._(isLoading: true);
  factory ApiResponse.error(String message) => ApiResponse._(errorMessage: message);

  bool get hasData => data != null;
  bool get hasError => errorMessage != null;
}
