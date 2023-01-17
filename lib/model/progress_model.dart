class ProgressTasks {
  int? id;
  double? progressOfDay;
  String? dateProgress;
  String? dateProgressYear;
  String? dateProgressmonth;
  String? dateProgressToday;
  String? isTodayBreak;

  ProgressTasks(
      {this.id,
      required this.dateProgress,
      this.progressOfDay,
      required this.dateProgressYear,
      required this.dateProgressmonth,
      required this.dateProgressToday,
      this.isTodayBreak});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'progressOfDay': progressOfDay,
      'dateProgress': dateProgress,
      'dateProgressYear': dateProgressYear,
      'dateProgressmonth': dateProgressmonth,
      'dateProgressToday': dateProgressToday,
      'isTodayBreak': isTodayBreak,
    };
  }

  ProgressTasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    progressOfDay = json['progressOfDay'];
    isTodayBreak = json['isTodayBreak'];
    dateProgress = json['dateProgress'].toString();
    dateProgressYear = json['dateProgressYear'].toString();
    dateProgressmonth = json['dateProgressmonth'].toString();
    dateProgressToday = json['dateProgressToday'].toString();
  }
}
