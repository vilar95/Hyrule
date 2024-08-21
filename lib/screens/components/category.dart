import 'package:flutter/material.dart';
import 'package:hyrule/controllers/api_controller.dart';
import 'package:hyrule/screens/results.dart';
import 'package:hyrule/utils/consts/categories.dart';

import '../../domain/models/entry.dart';

class Category extends StatefulWidget {
  const Category({Key? key, required this.category, this.isHighlight = false})
      : super(key: key);
  final String category;
  final bool isHighlight;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> with TickerProviderStateMixin {
  final ApiController apiController = ApiController();

  late AnimationController _scaleAnimationController;
  late AnimationController _imageColorAnimationController;

  @override
  void initState() {
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.8,
      upperBound: 1,
    );

    _imageColorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
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
    return Column(
      children: <Widget>[
        Flexible(
          child: InkWell(
            onTap: () async {
              await getEntries().then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Results(entries: value, category: widget.category),
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16.0),
            child: Ink(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(25, 167, 86, 0),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    width: 4.0,
                    color: const Color.fromARGB(255, 167, 86, 0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 6.0,
                        color: const Color.fromARGB(255, 167, 86, 0)
                            .withOpacity(0.2),
                        blurStyle: BlurStyle.outer),
                  ]),
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: _scaleAnimationController,
                child: AnimatedBuilder(
                  animation: _imageColorAnimationController,
                  builder: (context, child) {
                    return Center(
                      child: Image.asset(
                        "$imagePath${widget.category}.png",
                        fit: BoxFit.fitHeight,
                        color: Color.fromARGB(
                          255,
                          0,
                          60,
                          (255 *
                                  (_imageColorAnimationController.value - 1)
                                      .abs())
                              .floor(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            categories[widget.category]!,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white.withAlpha(200),
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }

  Future<List<Entry>> getEntries() async {
    return await apiController.getEntriesByCategory(category: widget.category);
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    _imageColorAnimationController.dispose();
    super.dispose();
  }
}
