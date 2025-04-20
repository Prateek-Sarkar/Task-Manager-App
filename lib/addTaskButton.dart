import 'package:flutter/material.dart';

class Addtaskbutton extends StatefulWidget {
  const Addtaskbutton({super.key});

  @override
  State<Addtaskbutton> createState() => _AddtaskbuttonState();
}

class Task {
  String name;
  bool isDone;

  Task({required this.name, this.isDone = false});
}

class _AddtaskbuttonState extends State<Addtaskbutton> {
  List<Task> todoList = [];

  void showAddTaskDialog() {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add New Task"),
          content: TextField(
            controller: taskController,
            decoration: InputDecoration(hintText: "Enter task name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                String task = taskController.text.trim();
                if (task.isNotEmpty) {
                  setState(() {
                    todoList.add(Task(name: task));
                  });
                }
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          // ✅ Add Task Button
          InkWell(
            onTap: () {
              showAddTaskDialog();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 208, 203, 255),
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 80,
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline, size: 30),
                  SizedBox(width: 10),
                  Text(
                    "Add Task",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // ✅ Show list or "No Tasks" message
          Expanded(
            child:
                todoList.isEmpty
                    ? Center(child: Text("No tasks yet!"))
                    : ListView.builder(
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: todoList[index].isDone,
                              onChanged: (bool? value) {
                                setState(() {
                                  todoList[index].isDone = value ?? false;
                                });
                              },
                            ),
                            title: Text(
                              todoList[index].name,
                              style: TextStyle(
                                fontSize: 16,
                                decoration:
                                    todoList[index].isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  todoList.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
