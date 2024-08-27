import 'package:flutter/material.dart';

class CategoryTransitionWidget extends StatefulWidget {
  final bool isHighlight;
  final Duration duration;
  final String imagePath;
  const CategoryTransitionWidget({
    super.key,
    required this.isHighlight,
    required this.duration,
    required this.imagePath,
  });

  @override
  State<CategoryTransitionWidget> createState() =>
      _CategoryTransitionWidgetState();
}

class _CategoryTransitionWidgetState extends State<CategoryTransitionWidget>
    with TickerProviderStateMixin {
  late AnimationController _scaleAnimationController;
  late AnimationController _imageColorAnimationController;
  late Animation<double> _scaleCurvedAnimation;

  @override
  void initState() {
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0.8,
      upperBound: 1,
    );
    _scaleCurvedAnimation = CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.easeInOut,
    );

    _imageColorAnimationController = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0,
      upperBound: 1,
    );

    if (widget.isHighlight) {
      _scaleAnimationController.repeat(
        reverse: true,
      );
      _imageColorAnimationController.repeat(
        reverse: true,
      );
    } else {
      _scaleAnimationController.animateTo(1);
      _imageColorAnimationController.animateTo(0);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CategoryTranstion(
      imageColorAnimationController: _imageColorAnimationController,
      scaleAnimationController: _scaleCurvedAnimation,
      imagePath: widget.imagePath,
    );
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    _imageColorAnimationController.dispose();
    super.dispose();
  }
}

class CategoryTranstion extends AnimatedWidget {
  final Animation<double> scaleAnimationController;
  final Animation<double> imageColorAnimationController;
  final String imagePath;

  const CategoryTranstion({
    super.key,
    required this.imageColorAnimationController,
    required this.scaleAnimationController,
    required this.imagePath,
  }) : super(
          listenable: imageColorAnimationController,
        );

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      alignment: Alignment.center,
      scale: scaleAnimationController,
      child: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.fitHeight,
          color: Color.fromARGB(
            255,
            0,
            60,
            (255 * (imageColorAnimationController.value - 1).abs()).floor(),
          ),
        ),
      ),
    );
  }
}
