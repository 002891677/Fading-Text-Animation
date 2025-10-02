import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  const FadingTextAnimation({super.key});

  @override
  State<FadingTextAnimation> createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  bool _isDarkMode = false;
  bool _showFrame = false;
  Color _textColor = Colors.blue;

  // Toggle fade animation
  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  // Toggle theme
  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  // Open color picker
  void pickColor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a text color'),
        content: BlockPicker(
          pickerColor: _textColor,
          onColorChanged: (color) {
            setState(() => _textColor = color);
          },
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  // Navigate to second screen
  void goToSecondScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondAnimationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fading Text Animation'),
          actions: [
            IconButton(
              icon: const Icon(Icons.color_lens),
              onPressed: pickColor,
            ),
            IconButton(
              icon: Icon(_isDarkMode ? Icons.nights_stay : Icons.wb_sunny),
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: GestureDetector(
          onHorizontalDragEnd: (_) => goToSecondScreen(),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Fading Text
                  GestureDetector(
                    onTap: toggleVisibility,
                    child: AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      child: Text(
                        'Hello, Flutter!',
                        style: TextStyle(
                          fontSize: 28,
                          color: _textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Switch for frame
                  SwitchListTile(
                    title: const Text('Show Frame Around Image'),
                    value: _showFrame,
                    onChanged: (value) {
                      setState(() {
                        _showFrame = value;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  // Rounded Image with frame
                  Container(
                    decoration: _showFrame
                        ? BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 3),
                            borderRadius: BorderRadius.circular(20),
                          )
                        : null,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/lion.jpg', // ✅ Updated image path
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: toggleVisibility,
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}

// Second Screen
class SecondAnimationScreen extends StatefulWidget {
  const SecondAnimationScreen({super.key});

  @override
  State<SecondAnimationScreen> createState() => _SecondAnimationScreenState();
}

class _SecondAnimationScreenState extends State<SecondAnimationScreen> {
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Animation')),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
          child: const Text(
            'Second Screen Animation',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
