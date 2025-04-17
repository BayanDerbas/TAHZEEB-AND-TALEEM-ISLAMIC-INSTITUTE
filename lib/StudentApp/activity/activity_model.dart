class ActivityModel {
  int? id;
  String? question;
  String? answer1;
  String? answer2;
  String? answer3;
  String? answer4;
  String? correctAnswer;
  String? startTime;
  int? duration;

  ActivityModel(
      {this.id,
      this.question,
      this.answer1,
      this.answer2,
      this.answer3,
      this.answer4,
      this.correctAnswer,
      this.startTime,
      this.duration});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer1 = json['answer1'];
    answer2 = json['answer2'];
    answer3 = json['answer3'];
    answer4 = json['answer4'];
    correctAnswer = json['correct_answer'];
    startTime = json['start_time'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer1'] = answer1;
    data['answer2'] = answer2;
    data['answer3'] = answer3;
    data['answer4'] = answer4;
    data['correct_answer'] = correctAnswer;
    data['start_time'] = startTime;
    data['duration'] = duration;
    return data;
  }
}
