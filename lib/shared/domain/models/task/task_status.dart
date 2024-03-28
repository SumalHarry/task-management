enum TaskStatus {
  TODO,
  DOING,
  DONE,
}

extension TaskStatusGetter on TaskStatus {
  String get title {
    switch (this) {
      case TaskStatus.TODO:
        return 'To-Do';
      case TaskStatus.DOING:
        return 'Doing';
      case TaskStatus.DONE:
        return 'Done';
      default:
        return '';
    }
  }

  String get value {
    switch (this) {
      case TaskStatus.TODO:
        return 'TODO';
      case TaskStatus.DOING:
        return 'DOING';
      case TaskStatus.DONE:
        return 'DONE';
      default:
        return '';
    }
  }
}
