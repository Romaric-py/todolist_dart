import 'dart:io';

import 'utils.dart';
import 'todolist.dart';


class App {
  
  String path;
  late TodoList todoList;
  late Map<String, Function> commands;
  bool running = false; // Initialisé par défaut

  // Constructeur
  App(this.path);

  // Initialiser l'application et charger les tâches
  void init() {
    todoList = TodoList.load(path); // Chargement de la liste des tâches
    commands = {
      'display all tasks': todoList.displayTodoList,
      'show details about a specific task': todoList.displayTask,
      'add a new task': todoList.addTask,
      'mark a task as done': todoList.markTaskAsDone,
      'update a task': todoList.updateTask,
      'remove a task': todoList.removeTask,
      'quit (exit)': this.quit,
    };
    running = true;
    print("Welcome to the CMCI's TodoListApp CLI made in Dart ");
  }

  int choose_action() {
    int i = 1;
    commands.forEach(((k, v) {
      animatedPrint("=> ${i}. ${k[0].toUpperCase() + k.substring(1)}");
      i++;
    }));

    int index = chooseIndex(
      commands.keys.toList(),
      "Choose an action you want to perform (using number)",
      "Invalid choice !!",
      false,
    );

    return index;
  }

  // Méthode pour quitter l'application
  void quit() {
    running = false;
    print("App closed.");
  }

  // run (menu + actions)
  void run() {
    print("\nChoose an action to perform on your todolist");
    int choice = choose_action();
    Function action = commands[commands.keys.elementAt(choice)]!;
    action();
    todoList.save(this.path);
    if (running) {
      sleep(Duration(seconds: 2));
      run();
    }
    ;
  }
}