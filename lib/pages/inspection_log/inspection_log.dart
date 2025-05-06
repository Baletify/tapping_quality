import 'package:flutter/material.dart';

class InspectionLog extends StatelessWidget {
  const InspectionLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assessment Log',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(color: Colors.blue, ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
