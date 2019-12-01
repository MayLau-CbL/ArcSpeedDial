import 'package:flutter/material.dart';

///
/// Basically the param of a [FloatingActionButton], only 3 more params used as the child of [FloatingActionButton],
class MainMenuFloatingActionButton {
  /// To set the widget after clicked the FAB
  final Widget closeMenuChild;
  final Color closeMenuForegroundColor;
  final Color closeMenuBackgroundColor;

  final Widget child;
  final Color foregroundColor;
  final Color backgroundColor;
  final String tooltip;
  final Color focusColor;
  final Color hoverColor;
  final Color splashColor;
  final Object heroTag;
  final Function() onPressed;
  final double elevation;
  final double focusElevation;
  final double hoverElevation;
  final double highlightElevation;
  final double disabledElevation;
  final bool mini;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final bool isExtended;
  final FocusNode focusNode;
  final bool autofocus;
  final MaterialTapTargetSize materialTapTargetSize;

  MainMenuFloatingActionButton({
    @required this.child,
    @required this.closeMenuChild,
    this.tooltip,
    this.closeMenuForegroundColor,
    this.foregroundColor,
    this.closeMenuBackgroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.heroTag, // if null use fab default
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    @required this.onPressed,
    this.mini = false,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.isExtended = false,
  })
      : assert(elevation == null || elevation >= 0.0),
        assert(focusElevation == null || focusElevation >= 0.0),
        assert(hoverElevation == null || hoverElevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0),
        assert(mini != null),
        assert(isExtended != null),
        assert(autofocus != null);
}
