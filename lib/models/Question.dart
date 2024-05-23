class Question {
  int? id;
  String? question;
  List<String>? options;
  int? answerIndex;

  Question({this.id, this.question, this.options, this.answerIndex});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    options = json['options'].cast<String>();
    answerIndex = json['answer_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['question'] = question;
    data['options'] = options;
    data['answer_index'] = answerIndex;
    return data;
  }
}

/*const List<Map<String, dynamic>> allQuestions = [
  {
    "questionsId": "nk_1",
    "id": 1,
    "question": "12 x 5 = ?",
    "options": ['40', '50', '60', '70'],
    "answer_index": 2
  },
  {
    "questionsId": "nk_1",
    "id": 2,
    "question": "Sıfır hariç en küçük asal sayı nedir?",
    "options": ['1', '2', '3', '5'],
    "answer_index": 1
  },
  {
    "questionsId": "nk_1",
    "id": 3,
    "question": "Karekök(144) kaçtır?",
    "options": ['10', '12', '14', '16'],
    "answer_index": 1
  },
  {
    "questionsId": "nk_1",
    "id": 4,
    "question": "Bir dizi sayının ortalaması bulunurken kullanılan matematiksel işlem hangisidir?",
    "options": ['Toplama', 'Çarpma', 'Bölme', 'Çıkarma'],
    "answer_index": 2
  },
  {
    "questionsId": "nk_1",
    "id": 5,
    "question": "Bir dik üçgenin hipotenüsü 10 birim, bir kenarı 6 birim ise, diğer kenarı kaç birimdir?",
    "options": ['4', '6', '8', '10'],
    "answer_index": 2
  },
  {
    "questionsId": "nk_1",
    "id": 6,
    "question": "2^3 kaçtır?",
    "options": ['4', '6', '8', '16'],
    "answer_index": 2
  },
  {
    "questionsId": "nk_1",
    "id": 7,
    "question": "Bir çemberin çevresini hesaplamak için kullanılan matematiksel sabit nedir?",
    "options": ['π (pi)', 'e', 'φ (altın oran)', '√2'],
    "answer_index": 0
  },
  {
    "questionsId": "nk_1",
    "id": 8,
    "question": "3! (Faktöriyel üç) kaçtır?",
    "options": ['3', '6', '9', '12'],
    "answer_index": 1
  },
  {
    "questionsId": "nk_1",
    "id": 9,
    "question": "Bir silindirin hacmi hesaplanırken kullanılan formül hangisidir?",
    "options": ['V = πr^2h', 'V = (1/3)πr^2h', 'V = (4/3)πr^3', 'V = 2πrh'],
    "answer_index": 0
  },
  {
    "questionsId": "nk_1",
    "id": 10,
    "question": "30'un 10'a bölümü kaçtır?",
    "options": ['2', '3', '4', '5'],
    "answer_index": 3
  },
  {
    "questionsId": "nk_1",
    "id": 11,
    "question": "Bir geometrik şeklin alanını hesaplamak için kullanılan matematiksel sabit nedir?",
    "options": ['π (pi)', 'e', 'φ (altın oran)', '√2'],
    "answer_index": 0
  },
  {
    "questionsId": "nk_1",
    "id": 12,
    "question": "Bir karenin çevresi nasıl hesaplanır?",
    "options": ['P = a^2', 'P = 2a', 'P = 4a', 'P = (1/2)a'],
    "answer_index": 2
  },
  {
    "questionsId": "nk_1",
    "id": 13,
    "question": "Bir zarın üzerindeki rakamların toplamı kaçtır?",
    "options": ['14', '21', '28', '36'],
    "answer_index": 1
  },
  {
    "questionsId": "nk_1",
    "id": 14,
    "question": "Bir açının derece cinsinden ölçüsü 90 ise, bu açının tipi nedir?",
    "options": ['Dik açı', 'Geniş açı', 'Dar açı', 'Tam açı'],
    "answer_index": 0
  },
  {
    "questionsId": "nk_1",
    "id": 15,
    "question": "Bir dairenin alanı hesaplanırken kullanılan matematiksel sabit nedir?",
    "options": ['π (pi)', 'e', 'φ (altın oran)', '√2'],
    "answer_index": 0
  },
  {
    "questionsId": "nk_1",
    "id": 16,
    "question": "Bir futbol takımının sahada kaç oyuncusu vardır?",
    "options": ['9', '10', '11', '12'],
    "answer_index": 2
  },
  {
    "questionsId": "nk_1",
    "id": 17,
    "question": "Bir yıl kaç gün sürer?",
    "options": ['365', '366', '367', '364'],
    "answer_index": 0
  },
  {
    "questionsId": "nk_1",
    "id": 18,
    "question": "10! (Faktöriyel on) kaçtır?",
    "options": ['10', '100', '1000', '3628800'],
    "answer_index": 3
  },
  {
    "questionsId": "nk_1",
    "id": 19,
    "question": "Bir dörtgenin iç açılarının toplamı kaçtır?",
    "options": ['180', '270', '360', '450'],
    "answer_index": 2
  },
  {
    "questionsId": "nk_1",
    "id": 20,
    "question": "3^4 kaçtır?",
    "options": ['9', '12', '27', '81'],
    "answer_index": 3
  },

  //nk2
  {
    "questionsId": "nk_2",
    "id": 2,
    "question": "Bir fonksiyonun grafiği kaç boyutludur?",
    "options": ["1", "2", "3", "4"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_2",
    "id": 3,
    "question": "Bir fonksiyonun tanım kümesi nedir?",
    "options": ["X eksen", "Y eksen", "X ve Y eksen", "Köşegen"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_2",
    "id": 4,
    "question": "Bir fonksiyonun değer kümesi nedir?",
    "options": ["X eksen", "Y eksen", "X ve Y eksen", "Köşegen"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_2",
    "id": 5,
    "question": "Bir fonksiyonun tersi var mıdır?",
    "options": ["Evet", "Hayır", "Belki", "Bilinmez"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_2",
    "id": 6,
    "question": "Bir fonksiyonun en geniş tanım kümesi nedir?",
    "options": ["Tüm reel sayılar", "Doğal sayılar", "Pozitif reel sayılar", "Sıfır"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_2",
    "id": 7,
    "question": "Bir fonksiyonun en geniş değer kümesi nedir?",
    "options": ["Tüm reel sayılar", "Doğal sayılar", "Pozitif reel sayılar", "Sıfır"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_2",
    "id": 8,
    "question": "Bir fonksiyonun tek bir x değeri için birden fazla y değeri alması durumu ne olarak adlandırılır?",
    "options": ["Birleşim", "Kesişim", "Tekil", "Çoklu"],
    "answer_index": 2
  },
  {
    "questionsId": "nk_2",
    "id": 9,
    "question": "Fonksiyonun lineer olup olmadığını kontrol etmek için hangi denklem kullanılır?",
    "options": ["y = mx + c", "y = x^2", "y = ax^2 + bx + c", "y = e^x"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_2",
    "id": 10,
    "question": "Bir fonksiyonun grafiği eğri ise, bu fonksiyonun ne olduğunu göstermek için hangi terim kullanılır?",
    "options": ["Doğru", "Küresel", "Parabol", "Hipotenüs"],
    "answer_index": 2
  },
  {
    "questionsId": "nk_2",
    "id": 11,
    "question": "Bir fonksiyonun grafiğinde, x eksenini kestiği noktaların toplamı nedir?",
    "options": ["Karekök", "Sıfır", "1", "Doğru"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_2",
    "id": 12,
    "question": "Bir fonksiyonun grafiğinde, y eksenini kestiği noktaların toplamı nedir?",
    "options": ["Karekök", "Sıfır", "1", "Doğru"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_2",
    "id": 13,
    "question": "Fonksiyonun bir x değeri için alabileceği maksimum veya minimum y değeri nedir?",
    "options": ["Fonksiyonun sıfır olduğu nokta", "Fonksiyonun eğim değeri", "Fonksiyonun en büyük veya en küçük değeri", "Fonksiyonun türevi"],
    "answer_index": 2
  },
  {
    "questionsId": "nk_2",
    "id": 14,
    "question": "Fonksiyonun türevi neyi ifade eder?",
    "options": ["Fonksiyonun grafiğindeki eğimi", "Fonksiyonun en büyük değeri", "Fonksiyonun en küçük değeri", "Fonksiyonun sıfır olduğu nokta"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_2",
    "id": 15,
    "question": "Fonksiyonun türevi pozitif olduğunda ne ifade eder?",
    "options": ["Fonksiyonun artışta olduğunu", "Fonksiyonun azalışta olduğunu", "Fonksiyonun sıfır olduğunu", "Fonksiyonun belirsiz olduğunu"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_2",
    "id": 16,
    "question": "Fonksiyonun türevi negatif olduğunda ne ifade eder?",
    "options": ["Fonksiyonun artışta olduğunu", "Fonksiyonun azalışta olduğunu", "Fonksiyonun sıfır olduğunu", "Fonksiyonun belirsiz olduğunu"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_2",
    "id": 17,
    "question": "Fonksiyonun türevi sıfır olduğunda ne ifade eder?",
    "options": ["Fonksiyonun artışta olduğunu", "Fonksiyonun azalışta olduğunu", "Fonksiyonun maksimum veya minimum noktasında olduğunu", "Fonksiyonun belirsiz olduğunu"],
    "answer_index": 2
  },
  {
    "questionsId": "nk_2",
    "id": 18,
    "question": "Bir fonksiyonun grafiği kaç noktadan oluşabilir?",
    "options": ["Sonsuz", "1", "2", "3"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_2",
    "id": 19,
    "question": "Bir fonksiyonun asimptotları kaç adet olabilir?",
    "options": ["Sonsuz", "1", "2", "3"],
    "answer_index": 3
  },
  {
    "questionsId": "nk_2",
    "id": 20,
    "question": "Bir fonksiyonun tersi olabilir mi?",
    "options": ["Evet", "Hayır", "Bazen", "Belirsiz"],
    "answer_index": 0
  },

  //nk3
  {
    "questionsId": "nk_3",
    "id": 1,
    "question": "Mantıkta 've' işareti hangi sembolle temsil edilir?",
    "options": ["∨", "∃", "∧", "¬"],
    "answer_index": 2
  },
  {
    "questionsId": "nk_3",
    "id": 2,
    "question": "Mantıkta 'veya' işareti hangi sembolle temsil edilir?",
    "options": ["∨", "∃", "∧", "¬"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_3",
    "id": 3,
    "question": "Mantıkta 'değil' işareti hangi sembolle temsil edilir?",
    "options": ["∨", "∃", "∧", "¬"],
    "answer_index": 3
  },
  {
    "questionsId": "nk_3",
    "id": 4,
    "question": "Mantıkta 'herhangi bir' veya 'bazı' ifadeleri hangi sembolle temsil edilir?",
    "options": ["∨", "∃", "∧", "¬"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_3",
    "id": 5,
    "question": "Bir ifade 'doğru' ve 'yanlış' olamayacak şekilde düzenlenirse, bu ifade hangi tür bir ifadedir?",
    "options": ["Doğruluk değeri", "İkili ifade", "Belirsiz ifade", "Tekil ifade"],
    "answer_index": 3
  },
  {
    "questionsId": "nk_3",
    "id": 6,
    "question": "Mantıkta 'eşitlik' işareti hangi sembolle temsil edilir?",
    "options": ["=", "≠", ">", "<"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_3",
    "id": 7,
    "question": "Mantıkta 'eşit değil' işareti hangi sembolle temsil edilir?",
    "options": ["=", "≠", ">", "<"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_3",
    "id": 8,
    "question": "Mantıkta 'büyüktür' işareti hangi sembolle temsil edilir?",
    "options": ["=", "≠", ">", "<"],
    "answer_index": 2
  },
  {
    "questionsId": "nk_3",
    "id": 9,
    "question": "Mantıkta 'küçüktür' işareti hangi sembolle temsil edilir?",
    "options": ["=", "≠", ">", "<"],
    "answer_index": 3
  },
  {
    "questionsId": "nk_3",
    "id": 10,
    "question": "Mantıkta 'büyük eşittir' işareti hangi sembolle temsil edilir?",
    "options": ["≤", "≥", ">", "<"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_3",
    "id": 11,
    "question": "Mantıkta 'küçük eşittir' işareti hangi sembolle temsil edilir?",
    "options": ["≤", "≥", ">", "<"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_3",
    "id": 12,
    "question": "Mantıkta 've' bağlacı doğru olan iki ifadenin sonucu ne olur?",
    "options": ["Doğru", "Yanlış", "Belirsiz", "Herhangi biri"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_3",
    "id": 13,
    "question": "Mantıkta 'veya' bağlacı doğru olan iki ifadenin sonucu ne olur?",
    "options": ["Doğru", "Yanlış", "Belirsiz", "Herhangi biri"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_3",
    "id": 14,
    "question": "Mantıkta 'değil' bağlacı doğru olan bir ifadenin sonucu ne olur?",
    "options": ["Doğru", "Yanlış", "Belirsiz", "Herhangi biri"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_3",
    "id": 15,
    "question": "Mantıkta 've' bağlacı yanlış olan iki ifadenin sonucu ne olur?",
    "options": ["Doğru", "Yanlış", "Belirsiz", "Herhangi biri"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_3",
    "id": 16,
    "question": "Mantıkta 'veya' bağlacı yanlış olan iki ifadenin sonucu ne olur?",
    "options": ["Doğru", "Yanlış", "Belirsiz", "Herhangi biri"],
    "answer_index": 3
  },
  {
    "questionsId": "nk_3",
    "id": 17,
    "question": "Mantıkta 'değil' bağlacı yanlış olan bir ifadenin sonucu ne olur?",
    "options": ["Doğru", "Yanlış", "Belirsiz", "Herhangi biri"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_3",
    "id": 18,
    "question": "Mantık ifadelerinde 'x ve y'nin eşit olduğu durum için hangi sembol kullanılır?",
    "options": ["=", "≠", ">", "<"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_3",
    "id": 19,
    "question": "Mantık ifadelerinde 'x ve y'nin eşit olmadığı durum için hangi sembol kullanılır?",
    "options": ["=", "≠", ">", "<"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_3",
    "id": 20,
    "question": "Mantık ifadelerinde 'x y'den büyüktür' durumu için hangi sembol kullanılır?",
    "options": ["=", "≠", ">", "<"],
    "answer_index": 2
  },

  //nk4
  {
    "questionsId": "nk_4",
    "id": 1,
    "question": "Bir kümenin eleman sayısına ne denir?",
    "options": ["Küme", "Eleman", "Sıra", "Kardinalite"],
    "answer_index": 3
  },
  {
    "questionsId": "nk_4",
    "id": 2,
    "question": "Bir kümenin alt kümeleriyle ilgili hangisi doğrudur?",
    "options": ["Alt kümeleri yoktur.", "Sadece bir alt kümesi vardır.", "Her kümenin en az bir alt kümesi vardır.", "Alt kümelerinin sayısı kümeye bağlıdır."],
    "answer_index": 3
  },
  {
    "questionsId": "nk_4",
    "id": 3,
    "question": "Bir kümenin elemanlarının her biri tek sayı ise bu küme hangi tür kümedir?",
    "options": ["Boş küme", "Sıralı küme", "Çift küme", "Tek küme"],
    "answer_index": 3
  },
  {
    "questionsId": "nk_4",
    "id": 4,
    "question": "Bir kümenin bütün elemanları başka bir kümenin elemanı ise, bu kümeler arasındaki ilişki nedir?",
    "options": ["Kesişim", "Birleşim", "Alt küme", "Üst küme"],
    "answer_index": 3
  },
  {
    "questionsId": "nk_4",
    "id": 5,
    "question": "A={1, 2, 3} ve B={3, 4, 5} kümesinin kesişimi nedir?",
    "options": ["{1, 2}", "{3}", "{3, 4, 5}", "{}"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_4",
    "id": 6,
    "question": "A={a, b, c} ve B={b, c, d} kümesinin birleşimi nedir?",
    "options": ["{a, b, c, d}", "{a, b, c}", "{b, c}", "{a, d}"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_4",
    "id": 7,
    "question": "A={1, 2, 3, 4} ve B={3, 4, 5} kümesinin farkı nedir?",
    "options": ["{1, 2, 3, 4}", "{1, 2}", "{5}", "{3, 4}"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_4",
    "id": 8,
    "question": "A={x | x bir çift sayıdır} kümesinin tanım kümesi nedir?",
    "options": ["Bütün pozitif tam sayılar", "Bütün negatif tam sayılar", "Bütün asal sayılar", "Bütün çift sayılar"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_4",
    "id": 9,
    "question": "A={x | x bir tek sayıdır} kümesinin tanım kümesi nedir?",
    "options": ["Bütün pozitif tam sayılar", "Bütün negatif tam sayılar", "Bütün asal sayılar", "Bütün çift sayılar"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_4",
    "id": 10,
    "question": "A={x | x bir üç basamaklı doğal sayıdır} kümesinin eleman sayısı nedir?",
    "options": ["899", "999", "900", "1000"],
    "answer_index": 2
  },
  {
    "questionsId": "nk_4",
    "id": 11,
    "question": "Boş kümenin eleman sayısı nedir?",
    "options": ["1", "0", "2", "Belirsiz"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_4",
    "id": 12,
    "question": "Bir kümenin her elemanının kendisiyle eşit olduğu küme hangisidir?",
    "options": ["Boş küme", "Birleşim kümesi", "Tek elemanlı küme", "Alt küme"],
    "answer_index": 2
  },
  {
    "questionsId": "nk_4",
    "id": 13,
    "question": "A={1, 2, 3} ve B={2, 3, 4} kümesinin kartezyen çarpımı nedir?",
    "options": ["{(1, 2), (1, 3), (1, 4), (2, 2), (2, 3), (2, 4), (3, 2), (3, 3), (3, 4)}", "{(1, 1), (2, 2), (3, 3)}", "{(1, 2), (2, 3), (3, 4)}", "{(2, 1), (3, 2), (4, 3)}"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_4",
    "id": 14,
    "question": "A={x | x bir asal sayıdır} ve B={x | x bir tek sayıdır} kümesinin kesişimi nedir?",
    "options": ["Boş küme", "{2}", "{3}", "{5}"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_4",
    "id": 15,
    "question": "A={x | x bir çift sayıdır} ve B={x | x bir tek sayıdır} kümesinin birleşimi nedir?",
    "options": ["Boş küme", "{2}", "{3}", "Tüm doğal sayılar"],
    "answer_index": 3
  },
  {
    "questionsId": "nk_4",
    "id": 16,
    "question": "Bir kümenin elemanları sıralı olabilir mi?",
    "options": ["Evet", "Hayır", "Bazen", "Belirsiz"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_4",
    "id": 17,
    "question": "A={x | x bir çift sayıdır} kümesinin eleman sayısı nedir?",
    "options": ["Sonsuz", "1", "2", "3"],
    "answer_index": 0
  },
  {
    "questionsId": "nk_4",
    "id": 18,
    "question": "A={1, 2, 3} kümesinin alt kümelerinin sayısı nedir?",
    "options": ["1", "2", "3", "4"],
    "answer_index": 3
  },
  {
    "questionsId": "nk_4",
    "id": 19,
    "question": "Bir kümenin elemanları sıralı olabilir mi?",
    "options": ["Evet", "Hayır", "Bazen", "Belirsiz"],
    "answer_index": 1
  },
  {
    "questionsId": "nk_4",
    "id": 20,
    "question": "A={x | x bir asal sayıdır} kümesinin tanım kümesi nedir?",
    "options": ["Pozitif tam sayılar", "Negatif tam sayılar", "Çift sayılar", "Belirsiz"],
    "answer_index": 0
  },

  //ia_1
  {
    "questionsId": "ia_1",
    "id": 1,
    "question": "Hangisi Dünya'nın en büyük okyanusudur?",
    "options": ["Pasifik Okyanusu", "Hint Okyanusu", "Atlantik Okyanusu", "Arktik Okyanusu"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_1",
    "id": 2,
    "question": "Hangi gezegen Güneş Sistemi'ndeki en büyük gezegendir?",
    "options": ["Jüpiter", "Merkür", "Satürn", "Dünya"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_1",
    "id": 3,
    "question": "Hangisi bir element değildir?",
    "options": ["Demir", "Gümüş", "Bronz", "Altın"],
    "answer_index": 2
  },
  {
    "questionsId": "ia_1",
    "id": 4,
    "question": "Hangi ülke Amazon Ormanları'nın en büyük kısmına sahiptir?",
    "options": ["Brezilya", "Kolombiya", "Peru", "Arjantin"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_1",
    "id": 5,
    "question": "Hangisi İtalya'nın başkenti değildir?",
    "options": ["Roma", "Milano", "Napoli", "Venedik"],
    "answer_index": 1
  },
  {
    "questionsId": "ia_1",
    "id": 6,
    "question": "Hangi ünlü ressam 'Mona Lisa' tablosunu yapmıştır?",
    "options": ["Leonardo da Vinci", "Vincent van Gogh", "Pablo Picasso", "Michelangelo"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_1",
    "id": 7,
    "question": "Hangisi 'Romeo ve Juliet' adlı eserin yazarıdır?",
    "options": ["William Shakespeare", "Charles Dickens", "Jane Austen", "Fyodor Dostoevsky"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_1",
    "id": 8,
    "question": "Hangisi Ege Denizi'nde bulunan bir ada değildir?",
    "options": ["Santorini", "Mykonos", "Sisam", "Korsika"],
    "answer_index": 3
  },
  {
    "questionsId": "ia_1",
    "id": 9,
    "question": "Hangi gezegenin uydusu Titan'dır?",
    "options": ["Satürn", "Jüpiter", "Mars", "Uranüs"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_1",
    "id": 10,
    "question": "Hangisi Birleşik Krallık'ta bulunan bir şehir değildir?",
    "options": ["Liverpool", "Dublin", "Manchester", "Glasgow"],
    "answer_index": 1
  },
  {
    "questionsId": "ia_1",
    "id": 11,
    "question": "Hangisi Afrika kıtasında bulunan bir ülke değildir?",
    "options": ["Kenya", "Nijerya", "Pakistan", "Gana"],
    "answer_index": 2
  },
  {
    "questionsId": "ia_1",
    "id": 12,
    "question": "Hangi dil İspanya'nın resmi dilidir?",
    "options": ["İspanyolca", "Fransızca", "İngilizce", "Portekizce"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_1",
    "id": 13,
    "question": "Hangisi Antik Yunan tanrılarından biri değildir?",
    "options": ["Zeus", "Poseidon", "Osiris", "Athena"],
    "answer_index": 2
  },
  {
    "questionsId": "ia_1",
    "id": 14,
    "question": "Hangisi bir renk değildir?",
    "options": ["Mavi", "Mor", "Turuncu", "Pembe"],
    "answer_index": 3
  },
  {
    "questionsId": "ia_1",
    "id": 15,
    "question": "Hangi müzik enstrümanı 'piyanist' tarafından çalınır?",
    "options": ["Piyano", "Gitar", "Keman", "Davul"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_1",
    "id": 16,
    "question": "Hangisi Birleşmiş Milletler'in merkezi değildir?",
    "options": ["New York", "Cenevre", "Paris", "Viyana"],
    "answer_index": 2
  },
  {
    "questionsId": "ia_1",
    "id": 17,
    "question": "Hangi ünlü fizikçi 'E=mc²' denklemini geliştirmiştir?",
    "options": ["Albert Einstein", "Isaac Newton", "Galileo Galilei", "Stephen Hawking"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_1",
    "id": 18,
    "question": "Hangisi bir zeka oyunudur?",
    "options": ["Golf", "Bilardo", "Sudoku", "Buz Hokeyi"],
    "answer_index": 2
  },
  {
    "questionsId": "ia_1",
    "id": 19,
    "question": "Hangi gezegenin yüzeyinde en yüksek sıcaklıkta yaşam mümkün değildir?",
    "options": ["Venüs", "Mars", "Jüpiter", "Satürn"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_1",
    "id": 20,
    "question": "Hangisi bir İngiliz yazar değildir?",
    "options": ["Jane Austen", "Charles Dickens", "J.K. Rowling", "Leo Tolstoy"],
    "answer_index": 3
  },

  //ia_2
  {
    "questionsId": "ia_2",
    "id": 1,
    "question": "Hangi ülkenin bayrağında beyaz renk bulunmaz?",
    "options": ["İtalya", "Fransa", "Rusya", "Japonya"],
    "answer_index": 1
  },
  {
    "questionsId": "ia_2",
    "id": 2,
    "question": "Hangi kıta üzerinde bulunan bir ülkedir İsrail?",
    "options": ["Avrupa", "Asya", "Afrika", "Okyanusya"],
    "answer_index": 1
  },
  {
    "questionsId": "ia_2",
    "id": 3,
    "question": "Hangisi bir UNESCO Dünya Mirası olarak listelenmiş bir yapı değildir?",
    "options": ["Taj Mahal", "Çin Seddi", "Özgürlük Heykeli", "Pisa Kulesi"],
    "answer_index": 2
  },
  {
    "questionsId": "ia_2",
    "id": 4,
    "question": "Hangi ünlü ressam 'Gece Yıldızı' tablosunu yapmıştır?",
    "options": ["Claude Monet", "Leonardo da Vinci", "Pablo Picasso", "Vincent van Gogh"],
    "answer_index": 3
  },
  {
    "questionsId": "ia_2",
    "id": 5,
    "question": "Hangi ülke Güney Amerika kıtasında bulunmaz?",
    "options": ["Honduras", "Arjantin", "Bolivya", "Kolombiya"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_2",
    "id": 6,
    "question": "Hangisi bir Viking tanrısı değildir?",
    "options": ["Zeus", "Thor", "Odin", "Loki"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_2",
    "id": 7,
    "question": "Hangi ünlü yazar '1984' romanını yazmıştır?",
    "options": ["J.R.R. Tolkien", "Ernest Hemingway", "Fyodor Dostoevsky", "George Orwell"],
    "answer_index": 3
  },
  {
    "questionsId": "ia_2",
    "id": 8,
    "question": "Hangisi bir Afrika ülkesi değildir?",
    "options": ["Tayland", "Etiyopya", "Nijerya", "Mısır"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_2",
    "id": 9,
    "question": "Hangisi bir müzik türü değildir?",
    "options": ["Frikik", "Rock", "Blues", "Jazz"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_2",
    "id": 10,
    "question": "Hangi ülkenin ana dili Fince değildir?",
    "options": ["Macaristan", "Estonya", "Finlandiya", "İsveç"],
    "answer_index": 3
  },
  {
    "questionsId": "ia_2",
    "id": 11,
    "question": "Hangi müzik enstrümanı 'viyolonsel' olarak da bilinir?",
    "options": ["Kontrbas", "Viola", "Keman", "Çello"],
    "answer_index": 3
  },
  {
    "questionsId": "ia_2",
    "id": 12,
    "question": "Hangi dil Latin alfabesiyle yazılmaz?",
    "options": ["Rusça", "Fransızca", "İtalyanca", "İngilizce"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_2",
    "id": 13,
    "question": "Hangisi bir spor dalı değildir?",
    "options": ["Basketbol", "Futbol", "Voleybol", "Rugby"],
    "answer_index": 3
  },
  {
    "questionsId": "ia_2",
    "id": 14,
    "question": "Hangi ünlü sanatçı 'Scream' tablosunu yapmıştır?",
    "options": ["Pablo Picasso", "Edvard Munch", "Vincent van Gogh", "Leonardo da Vinci"],
    "answer_index": 1
  },
  {
    "questionsId": "ia_2",
    "id": 15,
    "question": "Hangisi dünyanın en uzun nehri değildir?",
    "options": ["Mississippi Nehri", "Nil Nehri", "Amazon Nehri", "Yangtze Nehri"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_2",
    "id": 16,
    "question": "Hangi ünlü bilim insanı 'Evrim Teorisi'ni geliştirmiştir?",
    "options": ["Galileo Galilei", "Isaac Newton", "Albert Einstein", "Charles Darwin"],
    "answer_index": 3
  },
  {
    "questionsId": "ia_2",
    "id": 17,
    "question": "Hangi ülke 'Tango'nun doğum yeri olarak bilinir?",
    "options": ["Fransa", "İspanya", "Arjantin", "İtalya"],
    "answer_index": 2
  },
  {
    "questionsId": "ia_2",
    "id": 18,
    "question": "Hangi yıl Leonardo da Vinci 'Son Akşam Yemeği' tablosunu yapmıştır?",
    "options": ["1507", "1498", "1523", "1512"],
    "answer_index": 1
  },
  {
    "questionsId": "ia_2",
    "id": 19,
    "question": "Hangisi bir Sherlock Holmes romanı değildir?",
    "options": ["Veba Günleri", "Boş Ev", "Kırmızı Karga", "Baskerville Köpeği"],
    "answer_index": 0
  },
  {
    "questionsId": "ia_2",
    "id": 20,
    "question": "Hangisi bir Yunan tanrısı değildir?",
    "options": ["Mars", "Apollo", "Ares", "Zeus"],
    "answer_index": 0
  },

  //hloi_1
  {
    "questionsId": "hloi_1",
    "id": 1,
    "question": "Hangi yıl Amerika Birleşik Devletleri Bağımsızlık Bildirgesi'ni ilan etmiştir?",
    "options": ["1776", "1789", "1792", "1801"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 2,
    "question": "Hangi tarih aralığı Fransız Devrimi'ni kapsar?",
    "options": ["1789-1799", "1750-1770", "1800-1820", "1850-1870"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 3,
    "question": "Hangi yıl Leonardo da Vinci doğmuştur?",
    "options": ["1452", "1500", "1550", "1600"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 4,
    "question": "Hangi tarih aralığında I. Dünya Savaşı gerçekleşmiştir?",
    "options": ["1914-1918", "1939-1945", "1870-1871", "1945-1950"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 5,
    "question": "Hangi yıl Berlin Duvarı yıkılmıştır?",
    "options": ["1989", "1991", "1993", "1987"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 6,
    "question": "Hangi tarih aralığında Orta Çağ yaşanmıştır?",
    "options": ["500-1500", "1500-1800", "1000-1300", "1800-2000"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 7,
    "question": "Hangi yıl Amerika'da Büyük Ekonomik Buhran başlamıştır?",
    "options": ["1929", "1933", "1936", "1925"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 8,
    "question": "Hangi tarih aralığında Karanlık Çağ yaşanmıştır?",
    "options": ["500-1500", "1500-1800", "1000-1300", "1800-2000"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 9,
    "question": "Hangi yıl II. Dünya Savaşı sona ermiştir?",
    "options": ["1945", "1943", "1947", "1950"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 10,
    "question": "Hangi tarih aralığında Rönesans yaşanmıştır?",
    "options": ["14. ve 17. yüzyıl", "10. ve 13. yüzyıl", "18. ve 19. yüzyıl", "20. yüzyıl"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 11,
    "question": "Hangi yıl Hiroşima'ya atom bombası atılmıştır?",
    "options": ["1945", "1943", "1947", "1950"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 12,
    "question": "Hangi tarih aralığında İngiliz İç Savaşı gerçekleşmiştir?",
    "options": ["1642-1651", "1700-1720", "1750-1770", "1800-1820"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 13,
    "question": "Hangi yıl Berlin Kongresi toplanmıştır?",
    "options": ["1878", "1885", "1890", "1900"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 14,
    "question": "Hangi tarih aralığında Amerikan İç Savaşı gerçekleşmiştir?",
    "options": ["1861-1865", "1800-1820", "1850-1870", "1870-1875"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 15,
    "question": "Hangi yıl Titanic gemisi batmıştır?",
    "options": ["1912", "1907", "1915", "1920"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 16,
    "question": "Hangi tarih aralığında Napolyon Savaşları yaşanmıştır?",
    "options": ["1803-1815", "1700-1720", "1750-1770", "1820-1835"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 17,
    "question": "Hangi yıl İstanbul'un Fethi gerçekleşmiştir?",
    "options": ["1453", "1400", "1500", "1550"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 18,
    "question": "Hangi tarih aralığında İngiliz Devrimi gerçekleşmiştir?",
    "options": ["1688-1689", "1700-1720", "1750-1770", "1800-1820"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 19,
    "question": "Hangi yıl Fransız İhtilali başlamıştır?",
    "options": ["1789", "1776", "1793", "1801"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_1",
    "id": 20,
    "question": "Hangi tarih aralığında Osmanlı Devleti'nin kuruluşu gerçekleşmiştir?",
    "options": ["1299-1922", "1200-1500", "1400-1700", "1500-1800"],
    "answer_index": 0
  },

  {
    "questionsId": "hloi_2",
    "id": 1,
    "question": "Hangi yıl Karl Marx 'Komünist Manifesto'yu yayınlamıştır?",
    "options": ["1848", "1856", "1863", "1871"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 2,
    "question": "Hangi tarih aralığında İspanyol Engizisyonu faaliyet göstermiştir?",
    "options": ["1478-1834", "1500-1700", "1600-1800", "1700-1900"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 3,
    "question": "Hangi yıl Amerika Birleşik Devletleri İç Savaşı sona ermiştir?",
    "options": ["1865", "1870", "1860", "1855"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 4,
    "question": "Hangi tarih aralığında Osmanlı İmparatorluğu'nun yıkılışı gerçekleşmiştir?",
    "options": ["19. ve 20. yüzyıl başları", "18. ve 19. yüzyıl başları", "17. ve 18. yüzyıl başları", "16. ve 17. yüzyıl başları"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 5,
    "question": "Hangi yıl Amerika'da Köleliğin Kaldırılması Bildirisi ilan edilmiştir?",
    "options": ["1863", "1856", "1860", "1850"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 6,
    "question": "Hangi tarih aralığında Yeni Çağ yaşanmıştır?",
    "options": ["1500-1800", "1000-1300", "1800-2000", "500-1500"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 7,
    "question": "Hangi yıl Londra'da Büyük Yangın gerçekleşmiştir?",
    "options": ["1666", "1670", "1675", "1680"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 8,
    "question": "Hangi tarih aralığında Sanayi Devrimi yaşanmıştır?",
    "options": ["18. ve 19. yüzyıl", "17. ve 18. yüzyıl", "19. ve 20. yüzyıl", "16. ve 17. yüzyıl"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 9,
    "question": "Hangi yıl II. Viyana Kuşatması gerçekleşmiştir?",
    "options": ["1683", "1678", "1690", "1665"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 10,
    "question": "Hangi tarih aralığında Fransız İmparatorluğu kurulmuştur?",
    "options": ["19. yüzyıl başları", "18. yüzyıl başları", "17. yüzyıl başları", "16. yüzyıl başları"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 11,
    "question": "Hangi yıl Almanya'da Berlin Duvarı'nın yıkılmasıyla Almanya'nın birleşmesi tamamlandı?",
    "options": ["1990", "1989", "1991", "1988"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 12,
    "question": "Hangi tarih aralığında Büyük Buhran yaşanmıştır?",
    "options": ["1929-1939", "1930-1940", "1940-1950", "1919-1929"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 13,
    "question": "Hangi yıl ABD'de California Altını Keşfi gerçekleşmiştir?",
    "options": ["1848", "1850", "1830", "1860"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 14,
    "question": "Hangi tarih aralığında Aydınlanma Çağı yaşanmıştır?",
    "options": ["17. ve 18. yüzyıl", "16. ve 17. yüzyıl", "18. ve 19. yüzyıl", "15. ve 16. yüzyıl"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 15,
    "question": "Hangi yıl Çin'de İpek Yolu'nun keşfi gerçekleşmiştir?",
    "options": ["Han Hanedanlığı döneminde", "Tang Hanedanlığı döneminde", "Song Hanedanlığı döneminde", "Yuan Hanedanlığı döneminde"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 16,
    "question": "Hangi tarih aralığında Napolyon'un Mısır Seferi gerçekleşmiştir?",
    "options": ["1798-1801", "1800-1803", "1810-1812", "1820-1822"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 17,
    "question": "Hangi yıl Moğol İmparatorluğu'nun yıkılışı gerçekleşmiştir?",
    "options": ["14. yüzyılın sonları", "13. yüzyılın sonları", "15. yüzyılın sonları", "12. yüzyılın sonları"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 18,
    "question": "Hangi tarih aralığında Roma İmparatorluğu'nun yıkılışı gerçekleşmiştir?",
    "options": ["4. ve 5. yüzyıl", "2. ve 3. yüzyıl", "3. ve 4. yüzyıl", "1. ve 2. yüzyıl"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 19,
    "question": "Hangi yıl Amerika'nın keşfi gerçekleşmiştir?",
    "options": ["1492", "1498", "1500", "1485"],
    "answer_index": 0
  },
  {
    "questionsId": "hloi_2",
    "id": 20,
    "question": "Hangi tarih aralığında İlkçağ yaşanmıştır?",
    "options": ["MÖ 3000-MÖ 500", "MÖ 2000-MÖ 500", "MÖ 1000-MÖ 500", "MÖ 500-MÖ 1"],
    "answer_index": 0
  },
];*/
/*const List survival_questions = [//map list, Questions and answers stored locally
  {
    "questionsId": "surv_3",
    "id": 1,
    "question": "12 x 5 = ?",
    "options": ['40', '50', '60', '70'],
    "answer_index": 2
  },
  {
    "questionsId": "surv_3",
    "id": 2,
    "question": "Sıfır hariç en küçük asal sayı nedir?",
    "options": ['1', '2', '3', '5'],
    "answer_index": 1
  },
  {
    "questionsId": "surv_3",
    "id": 3,
    "question": "Karekök(144) kaçtır?",
    "options": ['10', '12', '14', '16'],
    "answer_index": 1
  },
  {
    "questionsId": "surv_3",
    "id": 4,
    "question": "Bir dizi sayının ortalaması bulunurken kullanılan matematiksel işlem hangisidir?",
    "options": ['Toplama', 'Çarpma', 'Bölme', 'Çıkarma'],
    "answer_index": 2
  },
  {
    "questionsId": "surv_3",
    "id": 5,
    "question": "Bir dik üçgenin hipotenüsü 10 birim, bir kenarı 6 birim ise, diğer kenarı kaç birimdir?",
    "options": ['4', '6', '8', '10'],
    "answer_index": 2
  },
  {
    "questionsId": "surv_3",
    "id": 6,
    "question": "2^3 kaçtır?",
    "options": ['4', '6', '8', '16'],
    "answer_index": 2
  },
  {
    "questionsId": "surv_3",
    "id": 7,
    "question": "Bir çemberin çevresini hesaplamak için kullanılan matematiksel sabit nedir?",
    "options": ['π (pi)', 'e', 'φ (altın oran)', '√2'],
    "answer_index": 0
  },
  {
    "questionsId": "surv_3",
    "id": 8,
    "question": "3! (Faktöriyel üç) kaçtır?",
    "options": ['3', '6', '9', '12'],
    "answer_index": 1
  },
  {
    "questionsId": "surv_3",
    "id": 9,
    "question": "Bir silindirin hacmi hesaplanırken kullanılan formül hangisidir?",
    "options": ['V = πr^2h', 'V = (1/3)πr^2h', 'V = (4/3)πr^3', 'V = 2πrh'],
    "answer_index": 0
  },
  {
    "questionsId": "surv_3",
    "id": 10,
    "question": "30'un 10'a bölümü kaçtır?",
    "options": ['2', '3', '4', '5'],
    "answer_index": 3
  },
  {
    "questionsId": "surv_3",
    "id": 11,
    "question": "Bir geometrik şeklin alanını hesaplamak için kullanılan matematiksel sabit nedir?",
    "options": ['π (pi)', 'e', 'φ (altın oran)', '√2'],
    "answer_index": 0
  },
  {
    "questionsId": "surv_3",
    "id": 12,
    "question": "Bir karenin çevresi nasıl hesaplanır?",
    "options": ['P = a^2', 'P = 2a', 'P = 4a', 'P = (1/2)a'],
    "answer_index": 2
  },
  {
    "questionsId": "surv_3",
    "id": 13,
    "question": "Bir zarın üzerindeki rakamların toplamı kaçtır?",
    "options": ['14', '21', '28', '36'],
    "answer_index": 1
  },
  {
    "questionsId": "surv_3",
    "id": 14,
    "question": "Bir açının derece cinsinden ölçüsü 90 ise, bu açının tipi nedir?",
    "options": ['Dik açı', 'Geniş açı', 'Dar açı', 'Tam açı'],
    "answer_index": 0
  },
  {
    "questionsId": "surv_3",
    "id": 15,
    "question": "Bir dairenin alanı hesaplanırken kullanılan matematiksel sabit nedir?",
    "options": ['π (pi)', 'e', 'φ (altın oran)', '√2'],
    "answer_index": 0
  },
  {
    "questionsId": "surv_3",
    "id": 16,
    "question": "Bir futbol takımının sahada kaç oyuncusu vardır?",
    "options": ['9', '10', '11', '12'],
    "answer_index": 2
  },
  {
    "questionsId": "surv_3",
    "id": 17,
    "question": "Bir yıl kaç gün sürer?",
    "options": ['365', '366', '367', '364'],
    "answer_index": 0
  },
  {
    "questionsId": "surv_3",
    "id": 18,
    "question": "10! (Faktöriyel on) kaçtır?",
    "options": ['10', '100', '1000', '3628800'],
    "answer_index": 3
  },
  {
    "questionsId": "surv_3",
    "id": 19,
    "question": "Bir dörtgenin iç açılarının toplamı kaçtır?",
    "options": ['180', '270', '360', '450'],
    "answer_index": 2
  },
  {
    "questionsId": "surv_3",
    "id": 20,
    "question": "3^4 kaçtır?",
    "options": ['9', '12', '27', '81'],
    "answer_index": 3
  },
];
const List testQ = [ //map list, Questions and answers stored locally
  {
    "id": 1,
    "questionsId": "test",
    "question": "1",
    "options": ['1', '2', '3', '4'],
    "answer_index": 2,
  },
  {
    "id": 2,
    "questionsId": "test",
    "question": "1",
    "options": ['1', '2', '3', '4'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "questionsId": "test",
    "question": "1",
    "options": ['1', '2', '3', '4'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "questionsId": "test",
    "question": "1",
    "options": ['1', '2', '3', '4'],
    "answer_index": 2,
  },
];*/
