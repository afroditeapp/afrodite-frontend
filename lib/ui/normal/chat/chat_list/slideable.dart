import 'package:flutter/material.dart';

/// A widget that allows its child to be slid horizontally with a limited range.
///
/// The sliding range is limited. When the user swipes, an icon
/// is revealed in the background. The widget will bounce back after the swipe
/// gesture ends.
class Slideable extends StatefulWidget {
  /// The widget that can be slid.
  final Widget child;

  /// Callback when the slide threshold is reached and the gesture is completed.
  final VoidCallback onSlideComplete;

  /// The icon to display in the background when sliding.
  final IconData icon;

  /// The color of the background icon.
  final Color? iconColor;

  /// The padding for the icon.
  final EdgeInsetsGeometry? iconPadding;

  /// The maximum slide distance in pixels.
  final double maxSlide;

  /// The threshold (as a fraction of maxSlide) at which onSlideComplete is triggered.
  final double threshold;

  const Slideable({
    required this.child,
    required this.onSlideComplete,
    required this.icon,
    this.iconColor,
    this.iconPadding,
    required this.maxSlide,
    required this.threshold,
    super.key,
  });

  @override
  State<Slideable> createState() => _SlideableState();
}

class _SlideableState extends State<Slideable> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _thresholdReachedController;
  late Animation<double> _animation;
  late Animation<double> _thresholdReachedAnimation;
  double _dragExtent = 0.0;
  bool _dragUnderway = false;
  bool _thresholdReached = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _dragExtent = _animation.value;
        });
      });

    _thresholdReachedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _thresholdReachedAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.3).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.3, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50.0,
      ),
    ]).animate(_thresholdReachedController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _thresholdReachedController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    _dragUnderway = true;
    _thresholdReached = false;
    if (_controller.isAnimating) {
      _controller.stop();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_dragUnderway) return;

    final delta = details.primaryDelta ?? 0.0;
    final newDragExtent = _dragExtent + delta;

    setState(() {
      // Limit the drag extent between 0 and maxSlide
      _dragExtent = newDragExtent.clamp(0.0, widget.maxSlide);

      // Check if threshold is reached
      final wasThresholdReached = _thresholdReached;
      _thresholdReached = _dragExtent >= (widget.maxSlide * widget.threshold);

      // Trigger animation when threshold is reached
      if (_thresholdReached && !wasThresholdReached) {
        _thresholdReachedController.forward(from: 0.0);
      }
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_dragUnderway) return;
    _dragUnderway = false;

    final thresholdReached = _dragExtent >= (widget.maxSlide * widget.threshold);

    if (thresholdReached) {
      widget.onSlideComplete();
    }

    // Animate back to the original position
    _animation = Tween<double>(
      begin: _dragExtent,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: Stack(
        children: [
          // Background with icon
          Positioned.fill(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: widget.iconPadding,
              child: Opacity(
                opacity: (_dragExtent / (widget.maxSlide * widget.threshold)).clamp(0.0, 1.0),
                child: AnimatedBuilder(
                  animation: _thresholdReachedAnimation,
                  builder: (context, child) {
                    return Transform.scale(scale: _thresholdReachedAnimation.value, child: child);
                  },
                  child: Icon(
                    widget.icon,
                    color: widget.iconColor ?? Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          // The slideable child
          Transform.translate(offset: Offset(_dragExtent, 0.0), child: widget.child),
        ],
      ),
    );
  }
}
