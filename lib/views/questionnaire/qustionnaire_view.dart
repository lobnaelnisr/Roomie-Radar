import 'package:flutter/material.dart';
import 'package:roomie_radar/viewmodels/questionnaire_viewmodel.dart';
import 'package:roomie_radar/models/questionnaire_model.dart';

class QuestionnaireView extends StatefulWidget {
  const QuestionnaireView({super.key});

  @override
  State<QuestionnaireView> createState() => _QuestionnaireViewState();
}

class _QuestionnaireViewState extends State<QuestionnaireView> {
  final viewModel = QuestionnaireViewModel();

  Map<int, String> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    final questions = viewModel.getQuestions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaire', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  viewModel.introductionText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/match.jpg',
                      fit: BoxFit.cover,
                      width: 300,
                      height: 200,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // List of questions
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Question text
                          Text(
                            question.questionText,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 15),
                          // List of answer options
                          Column(
                            children: question.answers.map((answer) {
                              return RadioListTile<String>(
                                title: Text(answer),
                                value: answer,
                                groupValue: selectedAnswers[index],
                                activeColor: Colors.orange,
                                onChanged: (value) {
                                  setState(() {
                                    selectedAnswers[index] = value!;
                                  });
                                  question.onAnswerSelected(value!);
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    print('Selected Answers: $selectedAnswers');
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
