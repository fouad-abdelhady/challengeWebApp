class Quiz {
  String? sId;
  String? quizTitle;
  String? course;
  String? topic;
  String? dueDate;
  String? classId;
  String? createdAt;
  String? updatedAt;

  Quiz(
      {this.sId,
      this.quizTitle,
      this.course,
      this.topic,
      this.dueDate,
      this.classId,
      this.createdAt,
      this.updatedAt});

  Quiz.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quizTitle = json['quizTitle'];
    course = json['course'];
    topic = json['topic'];
    dueDate = json['dueDate'];
    classId = json['classId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['quizTitle'] = quizTitle;
    data['course'] = course;
    data['topic'] = topic;
    data['dueDate'] = dueDate;
    data['classId'] = classId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
