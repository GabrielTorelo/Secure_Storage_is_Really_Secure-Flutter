import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget? actionButtons;
  final Direction actionDirection;
  final Widget content;

  const BackgroundGradient({
    super.key,
    this.actionButtons,
    this.actionDirection = Direction.left,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            if (actionButtons != null)
              Positioned(
                top: 20,
                left: actionDirection == Direction.left ? 20 : null,
                right: actionDirection == Direction.right ? 20 : null,
                child: actionButtons!,
              ),
            Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.onSecondaryFixedVariant,
                    Theme.of(context).colorScheme.onTertiaryFixedVariant,
                  ],
                  transform: GradientRotation(
                    BorderSide.strokeAlignOutside,
                  ),
                ),
              ),
            ),
            content,
          ],
        ),
      ),
    );
  }
}

enum Direction {
  left,
  right,
}
