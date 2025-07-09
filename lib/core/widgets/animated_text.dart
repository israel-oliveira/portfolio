import 'package:flutter/material.dart';

class AnimatedTitle extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final Duration delay;

  const AnimatedTitle({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = const Duration(milliseconds: 200),
  });

  @override
  State<AnimatedTitle> createState() => _AnimatedTitleState();
}

class _AnimatedTitleState extends State<AnimatedTitle>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start animation after delay
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ],
              stops: [0.0, _animation.value],
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style:
                widget.style?.copyWith(color: Colors.white) ??
                Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        );
      },
    );
  }
}

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final Duration delay;

  const TypewriterText({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 2000),
    this.delay = const Duration(milliseconds: 500),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = IntTween(
      begin: 0,
      end: widget.text.length,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start animation after delay
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          widget.text.substring(0, _animation.value),
          style: widget.style ?? Theme.of(context).textTheme.bodyLarge,
        );
      },
    );
  }
}
