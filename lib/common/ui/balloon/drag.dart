import 'package:flutter/material.dart';

class DragBalloon extends StatefulWidget {
  final Widget child;
  final void Function(Offset) onDragEnd;

  const DragBalloon({super.key, required this.child, required this.onDragEnd});

  @override
  State<DragBalloon> createState() => _DragBalloonState();
}

class _DragBalloonState extends State<DragBalloon> {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      maxSimultaneousDrags: 1,
      onDragEnd: (drag) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;

        widget.onDragEnd(renderBox.globalToLocal(drag.offset));
      },
      feedback: widget.child,
      childWhenDragging: Opacity(
        opacity: 0,
        child: widget.child,
      ),
      child: widget.child,
    );
  }
}
