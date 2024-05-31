import 'package:flutter/material.dart';
import 'package:todo_popper/api/api.dart';
import 'package:todo_popper/api/models/balloon.dart';
import 'package:todo_popper/common/balloon_form.dart';
import 'package:todo_popper/common/ui/alert.dart';
import 'package:todo_popper/common/ui/balloon/drag.dart';
import 'utils.dart';

class Balloon extends StatefulWidget {
  final BalloonModal balloon;

  const Balloon({super.key, required this.balloon});

  @override
  State<Balloon> createState() => _BalloonState();
}

class _BalloonState extends State<Balloon> {
  Offset position = const Offset(0, 0);

  @override
  void initState() {
    super.initState();

    position = Offset(widget.balloon.left, widget.balloon.top);
  }

  updatePosition(Offset offset) {
    BalloonModal balloon = BalloonUtils.setPosition(
        widget.balloon.copyWith(
          top: position.dy + offset.dy,
          left: position.dx + offset.dx,
        ),
        context);

    Offset newPosition = Offset(balloon.left, balloon.top);

    API.update(balloon);

    setState(() => position = newPosition);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final double width =
        size.width * importanceToSize[widget.balloon.importance]!;

    return Positioned(
      top: position.dy,
      left: position.dx,
      child: GestureDetector(
          onLongPress: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Alert(
                    title: 'Pop balloon',
                    message: 'Are you sure you want to pop this balloon?',
                    onConfirm: () {
                      API.toggleDone(widget.balloon.id);
                      Navigator.of(context).pop();
                    },
                    confirmText: 'Pop',
                  );
                });
          },
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return BalloonForm(balloon: widget.balloon);
                });
          },
          child: DragBalloon(
            onDragEnd: (offset) => updatePosition(offset),
            child: Container(
              width: width,
              height: width,
              padding: EdgeInsets.all(
                  importanceToPadding[widget.balloon.importance]!),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.balloon.color,
                border: Border.all(
                  color: widget.balloon.color,
                  width: 2.0,
                ),
              ),
              child: Center(
                  child: Text(widget.balloon.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: importanceToMaxLines[widget.balloon.importance],
                      style: BalloonUtils.sizeToTextStyle(
                          widget.balloon.importance, context))),
            ),
          )),
    );
  }
}
