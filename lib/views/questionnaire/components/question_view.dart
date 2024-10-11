import 'package:flutter/material.dart';
import 'package:roomie_radar/utils/app_colors.dart';

class Question extends StatelessWidget {
  final String questionText;
  final List<String> answers;
  final Function(String) onAnswerSelected;

  const Question({
    super.key,
    required this.questionText,
    required this.answers,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionText,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 8,
            ),
          ),
          const SizedBox(height: 12),
          ...answers.map(
                (answer) => Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appPrimaryColor.withOpacity(0.1),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), // Adjust padding if needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  shadowColor: appPrimaryColor.withOpacity(0.3),
                ),
                onPressed: () => onAnswerSelected(answer),
                child: Text(
                  answer,
                  style: const TextStyle(
                    color: appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
