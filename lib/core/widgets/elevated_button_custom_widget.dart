import 'package:flutter/material.dart';

class ElevatedButtonCustomWidget extends StatefulWidget {
  final void Function()? onpress;
  final Widget child;
  final Color color;
  final Color? hoverColor;
  const ElevatedButtonCustomWidget(
      {super.key,
      required this.child,
      required this.color,
      required this.onpress,
      this.hoverColor});

  @override
  State<ElevatedButtonCustomWidget> createState() =>
      _ButtonElevatedCustomWidgetState();
}

class _ButtonElevatedCustomWidgetState
    extends State<ElevatedButtonCustomWidget> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onpress,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: 48,
          decoration: BoxDecoration(
            color: isHovered ? widget.hoverColor : widget.color ,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: widget.child
          ),
        ),
      ),
    );
  }
}
