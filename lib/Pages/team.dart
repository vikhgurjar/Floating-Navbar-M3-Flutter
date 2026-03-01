import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  final void Function(int) onNavigate;
  final ScrollController controller;  
  const TeamPage({
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
          children: [Container(height: 2000, color: Color(0xFFFFF3E0))],
        ),
      ),
    );
}}