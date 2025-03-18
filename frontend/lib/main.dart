import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'services/answer_service.dart';

void main() {
  runApp(const AnswerBookApp());
}

class AnswerBookApp extends StatelessWidget {
  const AnswerBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '答案之书',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.notoSansTextTheme(),
        useMaterial3: true,
      ),
      home: const BookCoverPage(),
    );
  }
}

class BookCoverPage extends StatelessWidget {
  const BookCoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const GestureDrawPage(),
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple, Colors.indigo],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.book,
                  size: 120,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
                Text(
                  '答案之书',
                  style: GoogleFonts.notoSans(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '点击开始寻找答案',
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GestureDrawPage extends StatefulWidget {
  const GestureDrawPage({super.key});

  @override
  State<GestureDrawPage> createState() => _GestureDrawPageState();
}

class _GestureDrawPageState extends State<GestureDrawPage>
    with SingleTickerProviderStateMixin {
  final List<List<Offset>> _lines = [];
  List<Offset> _currentLine = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isDrawingComplete = false;
  Map<String, dynamic>? _randomAnswer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _fetchRandomAnswer();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchRandomAnswer() async {
    try {
      final answerService = AnswerService();
      final answer = await answerService.getRandomAnswer();
      setState(() => _randomAnswer = answer);
    } catch (e) {
      // 错误处理
    }
  }

  void _startBookTransition() {
    setState(() => _isDrawingComplete = true);
    _controller.forward().then((_) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) =>
              AnswerPage(answer: _randomAnswer),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          CustomPaint(
            painter: GesturePainter(_lines),
            size: Size.infinite,
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final value = _isDrawingComplete ? _animation.value : 0.0;
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(value * pi),
                alignment: Alignment.centerRight,
                child: child,
              );
            },
            child: GestureDetector(
              onPanStart: (details) {
                if (!_isDrawingComplete) {
                  setState(() {
                    _currentLine = [details.localPosition];
                    _lines.add(_currentLine);
                  });
                }
              },
              onPanUpdate: (details) {
                if (!_isDrawingComplete) {
                  setState(() {
                    _currentLine.add(details.localPosition);
                  });
                }
              },
              onPanEnd: (_) {
                if (!_isDrawingComplete) {
                  Future.delayed(
                      const Duration(milliseconds: 300), _startBookTransition);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'book_icon',
                        child: Icon(
                          Icons.auto_stories,
                          size: 80,
                          color: Colors.white
                              .withOpacity(_isDrawingComplete ? 0.0 : 1.0),
                        ),
                      ),
                      const SizedBox(height: 32),
                      AnimatedOpacity(
                        opacity: _isDrawingComplete ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Column(
                          children: [
                            Text(
                              '请画一个手势',
                              style: GoogleFonts.notoSans(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '在屏幕上任意绘制',
                              style: GoogleFonts.notoSans(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GesturePainter extends CustomPainter {
  final List<List<Offset>> lines;

  GesturePainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (var line in lines) {
      if (line.length < 2) continue;
      for (var i = 0; i < line.length - 1; i++) {
        canvas.drawLine(line[i], line[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(GesturePainter oldDelegate) => true;
}

class AnswerPage extends StatefulWidget {
  final Map<String, dynamic>? answer;
  const AnswerPage({super.key, this.answer});

  @override
  State<AnswerPage> createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    );
    _controller.forward().then((_) {
      setState(() => _showAnswer = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple, Colors.indigo],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateY((1 - _animation.value) * pi),
                    alignment: Alignment.center,
                    child: Container(
                      constraints:
                          const BoxConstraints(maxWidth: 300, maxHeight: 400),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'book_icon',
                      child: Icon(
                        Icons.auto_stories,
                        size: 80,
                        color:
                            Colors.white.withOpacity(_showAnswer ? 1.0 : 0.0),
                      ),
                    ),
                    const SizedBox(height: 32),
                    AnimatedOpacity(
                      opacity: _showAnswer ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 800),
                      child: Column(
                        children: [
                          Text(
                            '你的答案是：',
                            style: GoogleFonts.notoSans(
                              fontSize: 20,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.answer?['content'] ?? '暂无答案',
                            style: GoogleFonts.notoSans(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedOpacity(
                  opacity: _showAnswer ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: TextButton.icon(
                    icon: const Icon(Icons.book, color: Colors.white),
                    label: Text(
                      '合上答案之书',
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() => _showAnswer = false);
                      _controller.reverse().then((_) {
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 800),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const BookCoverPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
