import 'dart:developer';

import '../views/questionnaire/components/question_view.dart';

import '../models/questionnaire_model.dart';

class QuestionnaireViewModel {
  var introductionText =
      'Welcome to our Roommie Radar! This short survey will help us understand your preferences and find the perfect roommate match for you. Answer the questions honestly to maximize your chances of finding a compatible living partner! And finally GoodLuck!';
  
  // This method will store user responses
  void submitAnswers(String userId, Map<int, String> selectedAnswers) {
    final answers = selectedAnswers.map((key, value) => MapEntry(key.toString(), value));
    final questionnaireAnswers = QuestionnaireAnswers(userId: userId, answers: answers);

    // Here you can save the answers to Firebase or any other service
    log('User ID: $userId, Answers: ${questionnaireAnswers.toMap()}');
  }
  
  //list of questions
  List<Question> getQuestions() {
    return [
      Question(
        questionText: 'What is your preferred living environment?',
        answers: const ['Urban', 'Suburban', 'Rural', 'No preference'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'How tidy are you?',
        answers: const [
          'Very tidy',
          'Moderately tidy',
          'Not very tidy',
          'Messy'
        ],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'How do you feel about overnight guests?',
        answers: const ['No problem', 'Occasionally', 'Rarely', 'Not allowed'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'What is your sleep schedule?',
        answers: const ['Early bird', 'Night owl', 'Flexible', 'Varies'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'Do you smoke?',
        answers: const ['Yes', 'No', 'Occasionally', 'Trying to quit'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'How do you feel about pets?',
        answers: const [
          'Love them',
          'Okay with them',
          'Prefer not',
          'Allergic'
        ],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'How often do you cook at home?',
        answers: const ['Daily', 'A few times a week', 'Rarely', 'Never'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'How do you feel about shared groceries?',
        answers: const [
          'Open to it',
          'Only essentials',
          'Prefer separate',
          'No way'
        ],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'How much do you value privacy?',
        answers: const ['Very much', 'Somewhat', 'Not a priority', 'Depends'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'Do you work from home?',
        answers: const ['Full-time', 'Part-time', 'Rarely', 'Never'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'How often do you have friends over?',
        answers: const ['Often', 'Sometimes', 'Rarely', 'Never'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'What is your preferred noise level in the house?',
        answers: const ['Quiet', 'Moderate', 'Lively', 'No preference'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'How often do you clean?',
        answers: const ['Daily', 'Weekly', 'Occasionally', 'Only when needed'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'Do you have any dietary preferences or restrictions?',
        answers: const [
          'Vegetarian',
          'Vegan',
          'Gluten-free',
          'No restrictions'
        ],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'How do you handle conflict?',
        answers: const [
          'Directly',
          'Prefer to avoid',
          'Need time to cool off',
          'Depends'
        ],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'Are you comfortable sharing household chores?',
        answers: const [
          'Yes, equally',
          'Prefer my own tasks',
          'Only my area',
          'No'
        ],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'How often do you travel or leave town?',
        answers: const ['Frequently', 'Occasionally', 'Rarely', 'Never'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'What is your ideal room temperature?',
        answers: const ['Cool', 'Warm', 'Variable', 'No preference'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'Do you prefer a furnished or unfurnished room?',
        answers: const ['Furnished', 'Unfurnished', 'Either', 'No preference'],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
      Question(
        questionText: 'How do you prefer to handle shared expenses?',
        answers: const [
          'Split evenly',
          'Pay my share',
          'Rotate bills',
          'Depends'
        ],
        onAnswerSelected: (String answer) {
          log(answer);
        },
      ),
    ];
  }
}
