import 'package:flutter_project/shared/globals.dart';

class PaginatedResponse<T> {
  final int pageNumber;
  final int totalPages;

  static const limit = ITEMS_PER_PAGE;

  final List<T> data;

  PaginatedResponse(
      {required this.totalPages, required this.pageNumber, required this.data});

  factory PaginatedResponse.fromJson(dynamic json, List<T> data,
          {Function(dynamic json)? fixture}) =>
      PaginatedResponse(
        pageNumber: json['pageNumber'] ?? 0,
        totalPages: json['totalPages'] ?? 0,
        data: data,
      );
  @override
  String toString() {
    return 'PaginatedResponse(pageNumber:$pageNumber, totalPages:$totalPages, data:${data.length})';
  }
}
