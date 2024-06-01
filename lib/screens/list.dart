import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_popper/api/api.dart';
import 'package:todo_popper/api/hive.dart';
import 'package:todo_popper/common/main_app_wrapper.dart';
import 'package:todo_popper/common/ui/alert.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String> selectedBalloons = [];

  @override
  Widget build(BuildContext context) {
    return MainAppWrapper(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("All tasks"),
        actions: [
          if (selectedBalloons.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.check_box,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                for (var id in selectedBalloons) {
                  API.toggleDone(id);
                }
                setState(() {
                  selectedBalloons = [];
                });
              },
            ),
          if (selectedBalloons.isNotEmpty)
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Color(0xFFec2a5f),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Alert(
                        title: 'Delete selected balloons',
                        message:
                            'Are you sure you want to delete all selected balloons?',
                        onConfirm: () {
                          for (var id in selectedBalloons) {
                            API.delete(id);
                          }
                          setState(() {
                            selectedBalloons = [];
                          });
                          Navigator.of(context).pop();
                        },
                        confirmText: 'Delete',
                      );
                    });
              },
            ),
          if (selectedBalloons.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.update_rounded,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                for (var id in selectedBalloons) {
                  API.updateToToday(id);
                }
                setState(() {
                  selectedBalloons = [];
                });
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: HiveDB.balloonsBox.listenable(),
              builder: (context, box, child) {
                return ListView(
                  children: box.values
                      .toList()
                      .map((e) => CheckboxListTile(
                            title: Text(e['title'],
                                style: e['isDone']
                                    ? const TextStyle(
                                        color: Colors.grey,
                                        decorationColor: Colors.grey,
                                        decoration: TextDecoration.lineThrough)
                                    : null),
                            subtitle: Text(DateTime.parse(e['dueDate'])
                                .toLocal()
                                .toString()
                                .split(' ')[0]),
                            value: selectedBalloons.contains(e['id']),
                            onChanged: (value) {
                              if (value!) {
                                setState(() {
                                  selectedBalloons.add(e['id']);
                                });
                              } else {
                                setState(() {
                                  selectedBalloons.remove(e['id']);
                                });
                              }
                            },
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
