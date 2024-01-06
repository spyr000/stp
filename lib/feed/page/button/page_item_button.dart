import 'package:flutter/material.dart';

class PageItemButton extends StatefulWidget {
  final VoidCallback onTurningOn;
  final VoidCallback onTurningOff;
  final IconData icon;
  final bool isAlreadyToggled;

  const PageItemButton({
    Key? key,
    required this.onTurningOn,
    required this.onTurningOff,
    required this.icon,
    bool? isAlreadyToggled,
  })  : isAlreadyToggled = isAlreadyToggled ?? false,
        super(key: key);

  @override
  State<PageItemButton> createState() => _PageItemButtonState();
}

class _PageItemButtonState extends State<PageItemButton> {
  Color buttonColor = Colors.grey[700]!;

  void toggle() {
    buttonColor = isOff ? Colors.red : Colors.grey[700]!;
  }

  bool get isOff => buttonColor == Colors.grey[700]!;

  @override
  Widget build(BuildContext context) {
    if (widget.isAlreadyToggled) {
      setState(() {
        toggle();
      });
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 48.0,
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            toggle();
          });
          if (isOff) {
            widget.onTurningOff;
          } else {
            widget.onTurningOn();
          }
        },
        icon: Icon(
          widget.icon,
          color: buttonColor,
        ),
      ),
    );
  }
}
