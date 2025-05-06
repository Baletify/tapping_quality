import 'package:flutter/material.dart';

class AddAssessmentHo extends StatelessWidget {
  const AddAssessmentHo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Asesmen Sadap Atas',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
