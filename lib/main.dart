import './utility.dart';
import 'package:flutter/material.dart';
import './Navigation/main_navigation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            Positioned(
              top: 38,
              right: -60,
              height: 40,
              child: Transform.rotate(
                angle: 0.78,
                child: Material(
                  color: Colors.black,
                  child: Container(
                    color: Colors.red.withOpacity(0.9),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 38,
                      vertical: 4,
                    ),
                    child: TextButton.icon(
                      onPressed: launchGitHub,
                      icon: Icon(MdiIcons.github, size: 20),
                      label: const Text("@Damantha126"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      home: const MainNavigationScreen(),
    );
  }
}
