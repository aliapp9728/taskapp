class DoTask {
  int? id;
  int? isCompleted;
  String? task;
  String? achivement;
  String? dateYearTask;
  String? dateMonthTask;
  String? dateTodayTask;

  DoTask(
      {this.task,
      this.isCompleted,
      this.id,
      this.achivement,
      this.dateYearTask,
      this.dateMonthTask,
      this.dateTodayTask});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task': task,
      'achivement': achivement,
      'isCompleted': isCompleted,
      'dateYearTask': dateYearTask,
      'dateMonthTask': dateMonthTask,
      'dateTodayTask': dateTodayTask,
    };
  }

  DoTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isCompleted = json['isCompleted'];
    task = json['task'].toString();
    achivement = json['achivement'].toString();
    dateYearTask = json['dateYearTask'].toString();
    dateMonthTask = json['dateMonthTask'].toString();
    dateTodayTask = json['dateTodayTask'].toString();
  }
}
