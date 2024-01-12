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
  late Color buttonColor;

  @override
  void initState() {
    super.initState();
    buttonColor = widget.isAlreadyToggled ? Colors.red : Colors.grey[700]!;
  }

  void toggle() {
    setState(() {
      buttonColor =
          buttonColor == Colors.grey[700]! ? Colors.red : Colors.grey[700]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 48.0,
      ),
      child: IconButton(
        onPressed: () async {
          if (buttonColor == Colors.grey[700]!) {
            widget.onTurningOn();
          } else {
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
