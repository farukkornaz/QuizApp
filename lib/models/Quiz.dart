import 'Question.dart';

class Quiz {
  String? id;
  String? name;
  List<Question>? _questions = [];

  List<Question>? get questions => _questions;

  set questions(List<Question>? value) {
    _questions = value;
  }

  Quiz({this.id, this.name, List<Question>? questions}) : _questions = questions;

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions!.add(Question.fromJson(v));
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