import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedTextList extends StatefulWidget {
  final List<String> phrases;
  final Duration? duration;

  const AnimatedTextList({
    super.key,
    required this.phrases,
    this.duration,
  });

  @override
  State<AnimatedTextList> createState() => _AnimatedTextListState();
}

class _AnimatedTextListState extends State<AnimatedTextList>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late Timer _timer;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _timer = Timer.periodic(
        widget.duration ?? const Duration(seconds: 3), _changeText);
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _changeText(Timer timer) {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.phrases.length;
    });
    _controller.forward(from: 0);
    _timer = Timer.periodic(
        widget.duration ?? const Duration(seconds: 3), _changeText);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Text(
        widget.phrases[_currentIndex],
        key: ValueKey<String>(_currentIndex.toString()),
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
    );
  }
}
