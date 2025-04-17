class StudentTaqsimModel {
  int? active;
  int? written;
  int? oral;
  int? participation;
  int? quiz;
  int? exam;

  StudentTaqsimModel(
      {this.active,
      this.written,
      this.oral,
      this.participation,
      this.quiz,
      this.exam});

  StudentTaqsimModel.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    written = json['written'];
    oral = json['oral'];
    participation = json['participation'];
    quiz = json['quiz'];
    exam = json['exam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    data['written'] = written;
    data['oral'] = oral;
    data['participation'] = participation;
    data['quiz'] = quiz;
    data['exam'] = exam;
    return data;
  }
}
