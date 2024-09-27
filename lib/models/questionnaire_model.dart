class Questionnaire {
  final String userId; // ID of the user taking the questionnaire
  final Map<String, dynamic> answers; // A map of question IDs to answers
  final double compatibilityScore; // Calculated compatibility score

  Questionnaire({
    required this.userId,
    required this.answers,
    this.compatibilityScore = 0.0,
  });
}
