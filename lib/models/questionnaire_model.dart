class QuestionnaireAnswers {
  final String userId; // ID of the user taking the questionnaire
  final Map<String, dynamic> answers; // A map of question IDs to answers

  QuestionnaireAnswers({
    required this.userId,
    required this.answers,
  });

  QuestionnaireAnswers.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        answers = map['answers'];

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'answers': answers,
    };
  }
}

