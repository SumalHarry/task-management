import 'package:flutter_project/shared/globals.dart';

Map<String, dynamic> taskListMap({int? pageNumber}) => {
      "tasks": List.generate(ITEMS_PER_PAGE, (index) => taskMap),
      "pageNumber": (pageNumber ?? 0) + 1,
      "totalPages": 3,
    };
Map<String, dynamic> taskMap = {
  "id": "239a740c-9819-4b2e-a0d8-dce7b30522aa",
  "title": "Finish project report",
  "description": "Complete the final draft of the project report",
  "createdAt": "2023-04-23T15:45:00Z",
  "status": "TODO"
};
