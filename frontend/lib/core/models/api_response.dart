/// Generic API response wrappers matching backend ApiResponse DTOs.
class ApiSuccess<T> {
  final String? message;
  final T data;

  ApiSuccess({this.message, required this.data});

  factory ApiSuccess.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromData,
  ) {
    return ApiSuccess(
      message: json['message'] as String?,
      data: fromData(json['data']),
    );
  }
}

class PagedResponse<T> {
  final T data;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;

  PagedResponse({
    required this.data,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });

  factory PagedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromData,
  ) {
    return PagedResponse(
      data: fromData(json['data']),
      page: json['page'] as int,
      size: json['size'] as int,
      totalElements: json['totalElements'] as int,
      totalPages: json['totalPages'] as int,
    );
  }
}
