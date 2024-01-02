import 'package:flutter/material.dart';

class PageItemButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isChangingColorOnPress;
  final IconData icon;

  const PageItemButton(
      {Key? key,
      required this.onPressed,
      required this.isChangingColorOnPress,
      required this.icon,})
      : super(key: key);

  @override
  _PageItemButtonState createState() => _PageItemButtonState();
}

class _PageItemButtonState extends State<PageItemButton> {
  Color buttonColor = Colors.grey[700]!;

  void toggle() {
    this.buttonColor =
        (buttonColor == Colors.grey[700]!) ? Colors.red : Colors.grey[700]!;
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: const BoxConstraints(
          maxHeight: 48.0,
      ),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.redAccent,
            backgroundBlendMode: BlendMode.colorBurn,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
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
      ),
    );
  }
}
