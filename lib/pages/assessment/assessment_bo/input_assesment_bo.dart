import 'package:flutter/material.dart';
import 'package:tapping_quality/pages/assessment/assessment_result.dart';

class InputAssesmentBo extends StatefulWidget {
  const InputAssesmentBo({super.key});

  @override
  State<InputAssesmentBo> createState() => _InputAssesmentBoState();
}

class _InputAssesmentBoState extends State<InputAssesmentBo> {
  bool? isSmallChecked = false;
  bool? isMediumChecked = false;
  bool? isLargeChecked = false;
  String? selectedDepth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Input Assesment',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_leftCard(), _rightCard()],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
          Expanded(child: _assessmentItems()),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 8.0,
              right: 8.0,
              bottom: 35.0,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AssessmentResult(),
                  ),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.lightBlue[600],
                  borderRadius: BorderRadius.circular(8),
                ),
                width: double.infinity,
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _assessmentItems() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [_tappingDamage(), SizedBox(height: 10), _tappingDepth()],
        ),
      ),
    );
  }

  Container _tappingDepth() {
    return Container(
      height: 250,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 8.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: Text(
              'Kedalaman Sadap - Pilih Salah Satu',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RadioListTile<String>(
                      title: const Text(
                        'Kurang Dalam',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      value: 'Kurang Dalam',
                      groupValue: selectedDepth,
                      onChanged: (value) {
                        setState(() {
                          selectedDepth = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RadioListTile<String>(
                      title: const Text(
                        'Normatif',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      value: 'Normatif',
                      groupValue: selectedDepth,
                      onChanged: (value) {
                        setState(() {
                          selectedDepth = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RadioListTile(
                      title: const Text(
                        'Terlalu Dalam',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      value: 'Terlalu Dalam',
                      groupValue: selectedDepth,
                      onChanged: (value) {
                        setState(() {
                          selectedDepth = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _tappingDamage() {
    return Container(
      height: 250,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 8.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: Text(
              'Luka Sadap - Bisa Pilih Lebih dari 1',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CheckboxListTile(
                      title: const Text(
                        'Kecil (1 cm x 0.6 cm)',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      value: isSmallChecked,
                      onChanged: (value) {
                        setState(() {
                          isSmallChecked = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.platform,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CheckboxListTile(
                      title: const Text(
                        'Sedang (1.5 cm x 3 cm)',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      value: isMediumChecked,
                      onChanged: (value) {
                        setState(() {
                          isMediumChecked = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.platform,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CheckboxListTile(
                      title: const Text(
                        'Besar (>1.5 cm x 3 cm)',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      value: isLargeChecked,
                      onChanged: (value) {
                        setState(() {
                          isLargeChecked = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.platform,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _rightCard() {
    return Container(
      width: 180,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0, left: 5.0),
            child: const Text(
              'Detail Assessment:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Tanggal:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: const Text(
                    '19 Jan 2025',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Sistem Sadap:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: const Text(
                    'BO',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Task:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: const Text(
                    'A',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Kulit Sadap:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: const Text(
                    'Perawan',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _leftCard() {
    return Container(
      width: 180,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0, left: 5.0),
            child: const Text(
              'Detail Tapper:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'NIK:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: const Text(
                    'XXX-XXX',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Nama:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: const Text(
                    'John Doe',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Kemandoran:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: const Text(
                    'John Smith',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                child: const Text(
                  'Sub Divisi:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: const Text(
                    'II/D',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
