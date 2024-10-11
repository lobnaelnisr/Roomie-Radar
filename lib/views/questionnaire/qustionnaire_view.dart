import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:roomie_radar/viewmodels/questionnaire_viewmodel.dart';
import 'package:roomie_radar/views/questionnaire/components/question_view.dart';

class QuestionnaireView extends StatefulWidget {
  const QuestionnaireView({super.key});

  @override
  State<QuestionnaireView> createState() => _QuestionnaireViewState();
}

class _QuestionnaireViewState extends State<QuestionnaireView> {
  final viewModel = QuestionnaireViewModel();
  final Map<int, String> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    final questions = viewModel.getQuestions();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Questionnaire',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildIntroductionText(context),
              const SizedBox(height: 30),
              _buildImage(),
              const SizedBox(height: 40),
              _buildQuestionsList(questions),
              const SizedBox(height: 30),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroductionText(BuildContext context) {
    return Padding(
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
    );
  }

  Widget _buildImage() {
    return Center(
      child: Container(
        decoration: _buildImageBoxDecoration(),
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
    );
  }

  BoxDecoration _buildImageBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _buildQuestionsList(List<Question> questions) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      itemBuilder: (context, index) =>
          _buildQuestionCard(questions[index], index),
    );
  }

  Widget _buildQuestionCard(Question question, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.questionText,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 15),
            _buildAnswerOptions(question, index),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(Question question, int index) {
    return Column(
      children: question.answers.map((answer) {
        return RadioListTile<String>(
          title: Text(answer),
          value: answer,
          groupValue: selectedAnswers[index],
          activeColor: Colors.orange,
          onChanged: (value) => _onAnswerSelected(value!, question, index),
        );
      }).toList(),
    );
  }

  void _onAnswerSelected(String value, Question question, int index) {
    setState(() {
      selectedAnswers[index] = value;
    });
    question.onAnswerSelected(value);
  }

  Widget _buildSubmitButton() {
    return Align(
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
        onPressed: _onSubmitPressed,
        child: const Text(
          'Submit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _onSubmitPressed() {
    if (_areAllQuestionsAnswered()) {
      log('Selected Answers: $selectedAnswers');
      Navigator.pushNamed(context, '/roomListing');
    } else {
      _showIncompleteDialog();
    }
  }

  bool _areAllQuestionsAnswered() {
    final questions = viewModel.getQuestions();
    for (int i = 0; i < questions.length; i++) {
      if (!selectedAnswers.containsKey(i)) {
        return false;
      }
    }
    return true;
  }

  void _showIncompleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Incomplete'),
        content: const Text('Please answer all the questions before submitting.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
