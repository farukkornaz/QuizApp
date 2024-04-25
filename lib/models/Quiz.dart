import 'Question.dart';

class Quiz {
  String? id;
  String? name;
  List<Question>? questions;

  Quiz({this.id, this.name, this.questions});

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions!.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}