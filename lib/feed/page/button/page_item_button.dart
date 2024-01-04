import 'package:flutter/material.dart';

class PageItemButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isChangingColorOnPress;
  final IconData icon;

  const PageItemButton({
    Key? key,
    required this.onPressed,
    required this.isChangingColorOnPress,
    required this.icon,
  }) : super(key: key);

  @override
  _PageItemButtonState createState() => _PageItemButtonState();
}

class _PageItemButtonState extends State<PageItemButton> {
  Color buttonColor = Colors.grey[700]!;

  void toggle() {
    buttonColor =
        (buttonColor == Colors.grey[700]!) ? Colors.red : Colors.grey[700]!;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 48.0,
      ),
      child: IconButton(
        onPressed: () {
          if (widget.isChangingColorOnPress) {
            setState(() {
              toggle();
            });
          }
          widget.onPressed();
        },
        icon: Icon(
          widget.icon,
          color: buttonColor,
        ),
      ),
    );
  }
}
