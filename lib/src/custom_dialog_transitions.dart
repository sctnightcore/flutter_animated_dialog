import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Animates a 3D rotation of a widget around the Y-axis with perspective.
///
/// Example usage:
/// ```dart
/// Rotation3DTransition(
///   turns: _animation, // Animation<double> from 0.0 to 1.0
///   child: MyWidget(),
/// )
/// ```
class Rotation3DTransition extends AnimatedWidget {
  /// Creates a 3D rotation transition.
  ///
  /// The [turns] argument must not be null.
  const Rotation3DTransition({
    super.key,
    required Animation<double> turns,
    this.alignment = Alignment.center,
    this.child,
  })  : assert(turns != null),
        super(listenable: turns);

  /// The animation that controls the rotation of the child.
  ///
  /// A value of 1.0 corresponds to a full 360-degree rotation.
  Animation<double> get turns => listenable as Animation<double>;

  /// The alignment of the origin of the coordinate system around which the
  /// rotation occurs, relative to the size of the box.
  final Alignment alignment;

  /// The widget below this widget in the tree.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    final Matrix4 transform = Matrix4.identity()
      ..setEntry(3, 2, 0.0006) // Perspective
      ..rotateY(turnsValue * 2 * math.pi); // Full rotation
    return Transform(
      transform: transform,
      alignment: alignment, // Use provided alignment
      child: child,
    );
  }
}

/// Animates a 2D rotation of a widget around the Z-axis.
///
/// Example usage:
/// ```dart
/// CustomRotationTransition(
///   turns: _animation, // Animation<double> from 0.0 to 1.0
///   child: MyWidget(),
/// )
/// ```
class CustomRotationTransition extends AnimatedWidget {
  /// Creates a 2D rotation transition.
  ///
  /// The [turns] argument must not be null.
  const CustomRotationTransition({
    super.key,
    required Animation<double> turns,
    this.alignment = Alignment.center,
    this.child,
  })  : assert(turns != null),
        super(listenable: turns);

  /// The animation that controls the rotation of the child.
  ///
  /// A value of 1.0 corresponds to a full 360-degree rotation.
  Animation<double> get turns => listenable as Animation<double>;

  /// The alignment of the origin of the coordinate system around which the
  /// rotation occurs, relative to the size of the box.
  final Alignment alignment;

  /// The widget below this widget in the tree.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    final Matrix4 transform = Matrix4.rotationZ(turnsValue * 2 * math.pi); // Full rotation
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}
