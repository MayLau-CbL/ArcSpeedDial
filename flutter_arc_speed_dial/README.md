# flutter_arc_speed_dial

A bunch of FloatingActionButtons to consist speed dial in arc

## Usage

This shows Widget's full customizations:

```
SpeedDialMenuButton(
      {this.isEnableAnimation = true,
      required this.mainMenuFloatingActionButton,
      required this.isMainFABMini,
      required this.floatingActionButtonWidgetChildren,
      required this.isSpeedDialFABsMini,
      this.mainFABPosX = 10.0,
      this.mainFABPosY = 10.0,
      this.paddingBtwSpeedDialButton = 20.0,
      this.isShowSpeedDial = false,
      this.updateSpeedDialStatus
      });
```

1. [required] mainMenuFloatingActionButton is the Main Menu FloatingActionButton that required input a 'MainMenuFloatingActionButton'
2. [required] floatingActionButtonWidgetChildren is a List of FloatingActionButton that will show as the speed dial buttons
3. [required] isMainFABMini is to define the mainMenuFloatingActionButton is a 'normal size' or 'mini size' FloatingActionButton
4. [required] This library is required all speed dial buttons with same size which is normal and mini size. isSpeedDialFABsMini is to input which size is using
5. mainFABPosX and mainFABPosY is the x-y position of the mainMenuFloatingActionButton by aligning bottom-right.
6. paddingBtwSpeedDialButton is the space between each speed dial button
7. isEnableAnimation is to on-off the animation to display the speed dial buttons.
8. isShowSpeedDial is the bool for manually open or close the menu outside the widget.
9. updateSpeedDialStatus will return if any change of status within the widget.

### MainMenuFloatingActionButton
This is the main menu floating button for open and hide the speed dials. Basically having the same fields that is in the FloatingActionButton, but has 3 more field for identify the FAB when showing the close menu button.

```
MainMenuFloatingActionButton(
    required this.child,
    required this.closeMenuChild,
    this.closeMenuForegroundColor,
    this.foregroundColor,
    this.closeMenuBackgroundColor,
    this.backgroundColor,
    ...same as the FAB...
)
```

1. [required] child is the Icon when show the open menu icon.
2. [required] closeMenuChild is the Icon when show the hide menu icon.
3. foregroundColor is the icon color when show the open menu icon.
4. closeMenuForegroundColor is the icon color when show the hide menu icon.
5. backgroundColor is the button color when show the open menu icon.
6. closeMenuBackgroundColor is the button color when show the hide menu icon.

## Example

![](../on-off-button.gif)

```
import 'package:flutter/material.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isShowDial = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _getBodyWidget(),
      floatingActionButton: _getFloatingActionButton(),
    );
  }

  Widget _getFloatingActionButton() {
    return SpeedDialMenuButton(
      //if needed to close the menu after clicking sub-FAB
      isShowSpeedDial: _isShowDial,
      //manually open or close menu
      updateSpeedDialStatus: (isShow) {
        //return any open or close change within the widget
        this._isShowDial = isShow;
      },
      //general init
      isMainFABMini: false,
      mainMenuFloatingActionButton: MainMenuFloatingActionButton(
          mini: false,
          child: Icon(Icons.menu),
          onPressed: () {},
          closeMenuChild: Icon(Icons.close),
          closeMenuForegroundColor: Colors.white,
          closeMenuBackgroundColor: Colors.red),
      floatingActionButtonWidgetChildren: <FloatingActionButton>[
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.volume_off),
          onPressed: () {
            //if need to close menu after click
            _isShowDial = false;
            setState(() {});
          },
          backgroundColor: Colors.pink,
        ),
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.volume_down),
          onPressed: () {
            //if need to toggle menu after click
            _isShowDial = !_isShowDial;
            setState(() {});
          },
          backgroundColor: Colors.orange,
        ),
        FloatingActionButton(
          mini: true,
          child: Icon(Icons.volume_up),
          onPressed: () {
            //if no need to change the menu status
          },
          backgroundColor: Colors.deepPurple,
        ),
      ],
      isSpeedDialFABsMini: true,
      paddingBtwSpeedDialButton: 30.0,
    );
  }

  Widget _getBodyWidget() {
    return Container();
  }
}

```

## License

MIT