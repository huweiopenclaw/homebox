import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.data(T data) = ApiResponseData<T>;
  const factory ApiResponse.loading() = ApiResponseLoading;
  const factory ApiResponse.error(String message) = ApiResponseError;
}
