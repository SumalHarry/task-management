import 'package:flutter_project/shared/globals.dart';

class TaskPaginatedResponse<T> {
  final int totalPages;
  final int pageNumber;

  static const limit = ITEMS_PER_PAGE;

  final List<T> data;

  TaskPaginatedResponse(
      {required this.totalPages, required this.pageNumber, required this.data});

  factory TaskPaginatedResponse.fromJson(dynamic json, List<T> data,
          {Function(dynamic json)? fixture}) =>
      TaskPaginatedResponse(
        pageNumber: json['pageNumber'] ?? 0,
        totalPages: json['totalPages'] ?? 0,
        data: data,
      );
  @override
  String toString() {
    return 'PaginatedResponse(total:$totalPages, skip:$pageNumber, data:${data.length})';
  }
}
