class Quizes {
  final int? id,category;
  final String? quizName,questionsId;
  final bool? popular;

  Quizes({this.id, this.quizName,this.questionsId,this.category,this.popular});

}

// TODO: burası iptal edilecek
const List quiz_list = [
  {
    "id": 1,
    "category": 1,
    "quizName": "Matematik-1",
    "questionsId":"nk_1",
    "popular": false,
  },
  {
    "id": 2,
    "category": 1,
    "quizName": "Matematik-2",
    "questionsId": "nk_2",
    "popular": true,
  },
  {
    "id": 3,
    "category": 1,
    "quizName": "Matematik-3",
    "questionsId": "nk_3",
    "popular": true,
  },
  {
    "id": 4,
    "category": 1,
    "quizName": "Matematik-4",
    "questionsId":"nk_4",
    "popular": false,
  },
  {
    "id": 5,
    "category": 2,
    "quizName": "Genel kültür",
    "questionsId": "ia_1",
    "popular": true,
  },
  {
    "id": 6,
    "category": 2,
    "quizName": "Genel kültür",
    "questionsId":"ia_2",
    "popular": true,
  },
  {
    "id": 7,
    "category": 3,
    "quizName": "tarih",
    "questionsId":"hloi_1",
    "popular": false,
  },
  {
    "id": 8,
    "category": 3,
    "quizName": "tarih",
    "questionsId":"hloi_2",
    "popular": false,
  },
];