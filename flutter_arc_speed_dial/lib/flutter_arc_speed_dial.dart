library flutter_arc_speed_dial;

import 'dart:math';

import 'package:flutter/material.dart';

class SpeedDial extends StatefulWidget {
  final Widget mainFloatingActionButtonWidget;
  final bool isMainFABMini;
  final List<Widget> floatingActionButtonWidgetChildren;
  final bool isSpeedDialFABsMini;
  final int totalSpeedDialItem;
  final double mainFABPosX;
  final double mainFABPosY;
  final double difference;
  final bool isShowDial;
  final bool isEnableAnimation;

  const SpeedDial({
    @required this.isShowDial,
    this.isEnableAnimation = true,
    @required this.mainFloatingActionButtonWidget,
    this.isMainFABMini = false,
    @required this.floatingActionButtonWidgetChildren,
    this.isSpeedDialFABsMini = false,
    @required this.totalSpeedDialItem,
    this.mainFABPosX = 10.0,
    this.mainFABPosY = 10.0,
    this.difference = 0.0,
  });

  @override
  State<StatefulWidget> createState() {
    return _SpeedDialState();
  }
}

class _SpeedDialState extends State<SpeedDial>
    with SingleTickerProviderStateMixin {
  double _radius;
  double _diff;

  Animation<double> animation;
  AnimationController controller;

  _SpeedDialState() {
    this._radius = _getRadius(widget.totalSpeedDialItem);

    if(widget.difference!=0.0){
      _diff = widget.difference;
    }else {
      if (widget.isMainFABMini && widget.isSpeedDialFABsMini) {
        //all mini
        _diff = 0.0;
      } else if (!widget.isMainFABMini && !widget.isSpeedDialFABsMini) {
        //all main
        _diff = 0.0;
      } else if (widget.isMainFABMini && !widget.isSpeedDialFABsMini) {
        //speed
        _diff = 56.0 / 2 - 40.0 / 2;
      } else if (!widget.isMainFABMini && widget.isSpeedDialFABsMini) {
        //main
        _diff = 40.0 / 2 - 56.0 / 2;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(microseconds: 200), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SpeedDial oldWidget) {
    if(widget.isShowDial!=oldWidget.isShowDial){
      if(widget.isShowDial){
        controller.forward(from: 0.0).orCancel;
      }else{
        controller.reverse(from: 1.0).orCancel;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = List<Widget>();
    for (int i = 0; i < widget.totalSpeedDialItem; i++) {
      if (widget.isSpeedDialFABsMini) {
        children.add(_getSpeedDialFABWidget(widget.totalSpeedDialItem, i,
            _radius, widget.floatingActionButtonWidgetChildren[i]));
      }
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
    return _getFAB(
        widget.mainFABPosX +
            _diff +
            _getX(ttlNum, index, radius) * animation.value,
        widget.mainFABPosY +
            _diff +
            _getY(ttlNum, index, radius) * animation.value,
        child);
  }

  Widget _getFAB(double x, double y, Widget child) {
    return Positioned(
      bottom: y,
      right: x,
      child: child,
    );
  }

  double _getRadius(int numOfChild, [double d = 40.0, double padding = 20.0]) {
    double radius = ((numOfChild - 1) * (d + padding) * 2.0) / pi;

    print("radius = $radius");
    return radius;
  }

  double _getY(int numOfChild, int index, double radius) {
    double y = radius * sin(((pi / 2) / (numOfChild - 1)) * index);

    print("y = $y , index = $index");
    return y;
  }

  double _getX(int numOfChild, int index, double radius) {
    double x = radius * cos(((pi / 2) / (numOfChild - 1)) * index);

    print("x = $x , radius = $radius");
    return x;
  }
}
