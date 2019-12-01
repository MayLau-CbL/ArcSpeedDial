import 'package:flutter/material.dart';
import 'package:flutter_arc_speed_dial/flutter_arc_speed_dial.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';

class SpeedDialMenuButton extends StatefulWidget {
  /// Basically is a container of the [FloatingActionButton] params
  final MainMenuFloatingActionButton mainMenuFloatingActionButton;

  /// To specify whether main menu FAB is a mini one or normal one for calculating the diff
  final bool isMainFABMini;

  /// The children of the speed dial
  /// 0 ->  bottom to n -> top
  final List<FloatingActionButton> floatingActionButtonWidgetChildren;

  /// To specify whether speed dial FAB is a mini one or normal one for calculating the diff
  final bool isSpeedDialFABsMini;

  /// Main menu position from Bottom - Right
  final double mainFABPosX;
  final double mainFABPosY;

  /// The difference between the main Menu FAB and a speed dial FAB radius
  /// if not using [FloatingActionButton], this field is required to calculate manually
  /// in design
//  final double difference;

  /// Padding in radian in between each speed dial buttons
  /// Default is set to 20.0
  final double paddingBtwSpeedDialButton;

  /// Is enable animation when hide show the speed dial children
  final bool isEnableAnimation;

  final bool isShowSpeedDial;

  final void Function(bool) updateSpeedDialStatus;

  SpeedDialMenuButton(
      {this.isEnableAnimation = true,
      @required this.mainMenuFloatingActionButton,
      @required this.isMainFABMini,
      @required this.floatingActionButtonWidgetChildren,
      @required this.isSpeedDialFABsMini,
      this.mainFABPosX = 10.0,
      this.mainFABPosY = 10.0,
      this.paddingBtwSpeedDialButton = 20.0,
//    this.difference = 0.0,
      this.isShowSpeedDial = false,
      this.updateSpeedDialStatus});

  @override
  State<StatefulWidget> createState() {
    return _SpeedDialMenuButtonState();
  }
}

class _SpeedDialMenuButtonState extends State<SpeedDialMenuButton> {
  bool _isShowSpeedDial = false;

  @override
  void initState() {
    super.initState();
    _isShowSpeedDial = widget.isShowSpeedDial;
  }

  @override
  void didUpdateWidget(SpeedDialMenuButton oldWidget) {
//    print('didUpdateWidget');
//    print('old ${oldWidget.isShowSpeedDial.toString()} new ${widget
//        .isShowSpeedDial}');
//    if (oldWidget.isShowSpeedDial != widget.isShowSpeedDial) {
    this._isShowSpeedDial = widget.isShowSpeedDial;
//    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      isShowDial: this._isShowSpeedDial,
      mainFloatingActionButtonWidget: _getMainFAB(),
      floatingActionButtonWidgetChildren:
          widget.floatingActionButtonWidgetChildren,
      totalSpeedDialItem: widget.floatingActionButtonWidgetChildren.length,
      isEnableAnimation: widget.isEnableAnimation,
      isMainFABMini: widget.isMainFABMini,
      isSpeedDialFABsMini: widget.isSpeedDialFABsMini,
//      difference: widget.difference,
      paddingBtwSpeedDialButton: widget.paddingBtwSpeedDialButton,
      mainFABPosX: widget.mainFABPosX,
      mainFABPosY: widget.mainFABPosY,
    );
  }

  Widget _getMainFAB() {
    return FloatingActionButton(
      child: this._isShowSpeedDial
          ? widget.mainMenuFloatingActionButton.closeMenuChild
          : widget.mainMenuFloatingActionButton.child,
      tooltip: widget.mainMenuFloatingActionButton.tooltip,
      foregroundColor: this._isShowSpeedDial
          ? widget.mainMenuFloatingActionButton.closeMenuForegroundColor
          : widget.mainMenuFloatingActionButton.foregroundColor,
      backgroundColor: this._isShowSpeedDial
          ? widget.mainMenuFloatingActionButton.closeMenuBackgroundColor
          : widget.mainMenuFloatingActionButton.backgroundColor,
      focusColor: widget.mainMenuFloatingActionButton.focusColor,
      hoverColor: widget.mainMenuFloatingActionButton.hoverColor,
      splashColor: widget.mainMenuFloatingActionButton.splashColor,
      heroTag: widget.mainMenuFloatingActionButton.heroTag,
      elevation: widget.mainMenuFloatingActionButton.elevation,
      focusElevation: widget.mainMenuFloatingActionButton.focusElevation,
      hoverElevation: widget.mainMenuFloatingActionButton.hoverElevation,
      highlightElevation:
          widget.mainMenuFloatingActionButton.highlightElevation,
      disabledElevation: widget.mainMenuFloatingActionButton.disabledElevation,
      onPressed: () {
        this._isShowSpeedDial = !this._isShowSpeedDial;
        widget.updateSpeedDialStatus(this._isShowSpeedDial);
        widget.mainMenuFloatingActionButton.onPressed();
        setState(() {});
      },
      mini: widget.mainMenuFloatingActionButton.mini,
      shape: widget.mainMenuFloatingActionButton.shape,
      clipBehavior: widget.mainMenuFloatingActionButton.clipBehavior,
      focusNode: widget.mainMenuFloatingActionButton.focusNode,
      autofocus: widget.mainMenuFloatingActionButton.autofocus,
      materialTapTargetSize:
          widget.mainMenuFloatingActionButton.materialTapTargetSize,
      isExtended: widget.mainMenuFloatingActionButton.isExtended,
    );
  }
}
