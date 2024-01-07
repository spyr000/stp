import 'package:flutter/material.dart';

class FavouritesButton extends StatefulWidget {
  final VoidCallback onTurningOn;
  final VoidCallback onTurningOff;
  final IconData icon;
  final bool isAlreadyToggled;

  const FavouritesButton({
    Key? key,
    required this.onTurningOn,
    required this.onTurningOff,
    required this.icon,
    bool? isAlreadyToggled,
  })  : isAlreadyToggled = isAlreadyToggled ?? false,
        super(key: key);

  @override
  State<FavouritesButton> createState() => _FavouritesButtonState();
}

class _FavouritesButtonState extends State<FavouritesButton> {
  Color buttonColor = Colors.grey[700]!;

  void toggle() {
    print(isOff);
    setState(() {
      buttonColor = isOff ? Colors.red : Colors.grey[700]!;
    });
  }

  bool get isOff => buttonColor == Colors.grey[700]!;

  @override
  Widget build(BuildContext context) {
    if (widget.isAlreadyToggled) {
      setState(() {
        buttonColor = Colors.red;
      });
    }
    ;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 48.0,
      ),
      child: IconButton(
        onPressed: () {
          if (isOff) {
            print('turn off');
            widget.onTurningOn();
          } else {
            print('turn on');
            widget.onTurningOff();
          }
          toggle();
        },
        icon: Icon(
          widget.icon,
          color: buttonColor,
        ),
      ),
    );
  }
}
