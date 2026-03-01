import 'package:flutter/material.dart';

class CardsPage extends StatelessWidget {
  final void Function(int) onNavigate;
  final ScrollController controller;  
  const CardsPage({
    super.key,
    required this.onNavigate,
    required this.controller,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [Container(height: 2000, color: Color(0xFFF3E5F5))],
        ),
      ),
    );
}}