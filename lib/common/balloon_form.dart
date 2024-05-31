import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_popper/api/api.dart';
import 'package:todo_popper/api/models/balloon.dart';
import 'package:todo_popper/common/router.dart';
import 'package:todo_popper/common/ui/balloon/balloon.dart';
import 'package:todo_popper/common/ui/balloon/utils.dart';
import 'package:todo_popper/common/ui/button.dart';
import 'package:todo_popper/common/ui/input.dart';

class BalloonForm extends StatefulWidget {
  final BalloonModal? balloon;

  const BalloonForm({super.key, this.balloon});

  @override
  State<BalloonForm> createState() => _BalloonFormState();
}

class _BalloonFormState extends State<BalloonForm> {
  String title = "";
  String description = "";
  BalloonImportance importance = BalloonImportance.low;
  Color color = balloonsColors[0];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.balloon == null) return;

    title = widget.balloon!.title;
    description = widget.balloon!.description;
    importance = widget.balloon!.importance;
    color = widget.balloon!.color;
  }

  void handleSave() async {
    if (title.isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      BalloonModal doc = BalloonModal(
        id: widget.balloon?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        importance: importance,
        color: color,
        top: widget.balloon?.top ?? 0,
        left: widget.balloon?.left ?? 0,
        createdAt: widget.balloon?.createdAt ?? DateTime.now(),
        dueDate: widget.balloon?.createdAt ?? DateTime.now(),
        isDone: widget.balloon?.isDone ?? false,
      );

      if (widget.balloon != null) {
        await API.update(doc);
      } else {
        await API.create(doc);
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDisabled = title.isEmpty;

    return Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Input(
              label: "Title",
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              initialValue: title,
            ),
            const SizedBox(height: 16),
            Input(
              label: "Description",
              initialValue: description,
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 10,
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text("Priority"),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Row(
                children: [
                  ...BalloonImportance.values.map((e) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            importance = e;
                          });
                        },
                        child: Container(
                          width: (size.width - 64 - 4) / 3,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: e == importance
                                ? Theme.of(context).primaryColor
                                : null,
                            borderRadius: BorderRadius.only(
                              topLeft: e == BalloonImportance.low
                                  ? Radius.circular(28)
                                  : Radius.zero,
                              bottomLeft: e == BalloonImportance.low
                                  ? Radius.circular(28)
                                  : Radius.zero,
                              topRight: e == BalloonImportance.high
                                  ? Radius.circular(28)
                                  : Radius.zero,
                              bottomRight: e == BalloonImportance.high
                                  ? Radius.circular(28)
                                  : Radius.zero,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              e.name,
                              style: TextStyle(
                                color: e == importance ? Colors.white : null,
                              ),
                            ),
                          ),
                        ));
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text("Color"),
            const SizedBox(height: 8),
            Row(
              children: [
                ...balloonsColors.map((e) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          color = e;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            right: e == balloonsColors.last ? 0 : 6),
                        width: (size.width -
                                64 -
                                4 -
                                ((balloonsColors.length - 1) * 6)) /
                            balloonsColors.length,
                        height: (size.width -
                                64 -
                                4 -
                                ((balloonsColors.length - 1) * 6)) /
                            balloonsColors.length,
                        decoration: BoxDecoration(
                          color: e,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                e == color ? Colors.white : Colors.transparent,
                            width: 10,
                          ),
                        ),
                      ));
                }),
              ],
            ),
            const SizedBox(height: 16),
            Button(
                loading: isLoading,
                text: "Save Balloon",
                disabled: isDisabled,
                onTap: handleSave)
          ],
        ));
  }
}
