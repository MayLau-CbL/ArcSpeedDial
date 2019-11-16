library flutter_arc_speed_dial;

import 'dart:math';

import 'package:flutter/material.dart';

class SpeedDial extends StatefulWidget {
  final bool isShowDial;
  final FloatingActionButton mainFloatingActionButtonWidget;

  /// To specify whether main menu FAB is a mini one or normal one for calculating the diff
  final bool isMainFABMini;

  /// The children of the speed dial
  final List<FloatingActionButton> floatingActionButtonWidgetChildren;

  /// To specify whether speed dial FAB is a mini one or normal one for calculating the diff
  final bool isSpeedDialFABsMini;

  /// total number of speed dial
  final int totalSpeedDialItem;

  /// Main menu position from Bottom - Right
  final double mainFABPosX;
  final double mainFABPosY;

  /// The difference between the main Menu FAB and a speed dial FAB radius
  /// if not using [FloatingActionButton], this field is required to calculate manually
  /// in design...
//  final double difference;

  /// Padding in radian in between each speed dial buttons
  /// Default is set to 20.0
  final double paddingBtwSpeedDialButton;

  /// Is enable animation when hide show the speed dial children
  final bool isEnableAnimation;

  const SpeedDial(
      {this.isShowDial = false,
      this.isEnableAnimation = true,
      @required this.mainFloatingActionButtonWidget,
      @required this.isMainFABMini,
      @required this.floatingActionButtonWidgetChildren,
      @required this.isSpeedDialFABsMini,
      @required this.totalSpeedDialItem,
      this.mainFABPosX = 10.0,
      this.mainFABPosY = 10.0,
      this.paddingBtwSpeedDialButton = 20.0
//    this.difference = 0.0,
      });

  @override
  State<StatefulWidget> createState() {
    return _SpeedDialState();
  }
}

class _SpeedDialState extends State<SpeedDial>
    with SingleTickerProviderStateMixin {
  static const double NORMAL_FAB_DIAMETER = 56.0;
  static const double MINI_FAB_DIAMETER = 40.0;
  static const double NORMAL_FAB_RADIUS = 28.0;
  static const double MINI_FAB_RADIUS = 20.0;

  double _radius;
  double _diff;

  @override
  void initState() {
    super.initState();

    this._radius = _getRadius(
        widget.totalSpeedDialItem,
        widget.isSpeedDialFABsMini ? MINI_FAB_DIAMETER : NORMAL_FAB_DIAMETER,
        widget.paddingBtwSpeedDialButton);

//    if (widget.difference != 0.0) {
//      _diff = widget.difference;
//    } else {
    if (widget.isMainFABMini && widget.isSpeedDialFABsMini) {
      //all mini
      _diff = 0.0;
    } else if (!widget.isMainFABMini && !widget.isSpeedDialFABsMini) {
      //all main
      _diff = 0.0;
    } else if (widget.isMainFABMini && !widget.isSpeedDialFABsMini) {
      //speed
      _diff = MINI_FAB_RADIUS - NORMAL_FAB_RADIUS;
    } else if (!widget.isMainFABMini && widget.isSpeedDialFABsMini) {
      //main
      _diff = NORMAL_FAB_RADIUS - MINI_FAB_RADIUS;
    }
//    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List<Widget>();
    for (int i = 0; i < widget.totalSpeedDialItem; i++) {
      children.add(_getSpeedDialFABWidget(widget.totalSpeedDialItem, i, _radius,
          widget.floatingActionButtonWidgetChildren[i]));
    }

    children.add(Positioned(
      bottom: widget.mainFABPosY,
      right: widget.mainFABPosX,
      child: widget.mainFloatingActionButtonWidget,
    ));

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomRight,
      children: children,
    );
  }

  Widget _getSpeedDialFABWidget(
      int ttlNum, int index, double radius, Widget child) {
    return _getFAB(widget.mainFABPosX + _diff + _getX(ttlNum, index, radius),
        widget.mainFABPosY + _diff + _getY(ttlNum, index, radius), child);
  }

  Widget _getFAB(double x, double y, Widget child) {
    return Positioned(
      bottom: y,
      right: x,
      child: widget.isEnableAnimation
          ? AnimatedOpacity(
              curve: Curves.linear,
              opacity: widget.isShowDial ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 100),
              child: child)
          : child,
    );
  }

  double _getRadius(int numOfChild, double d, double padding) {
    double radius = ((numOfChild - 1) * (d + padding) * 2.0) / pi;

//    print("radius = $radius");
    return radius;
  }

  double _getY(int numOfChild, int index, double radius) {
    double y = radius * sin(((pi / 2) / (numOfChild - 1)) * index);

//    print("y = $y , index = $index");
    return y;
  }

  double _getX(int numOfChild, int index, double radius) {
    double x = radius * cos(((pi / 2) / (numOfChild - 1)) * index);

//    print("x = $x , radius = $radius");
    return x;
  }
}
