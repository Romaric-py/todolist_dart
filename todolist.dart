import 'dart:convert';
import 'dart:io';
import 'utils.dart';
import 'task.dart';

class TodoList {
  List<Task> tasksList;

  // Constructeur
  TodoList(this.tasksList);

  // afficher toutes les tâches
  void displayTodoList() {
    int index = 1;
    print("\nTasks List\n");
    this.tasksList.forEach((task) {
      animatedPrint("$index. ${task.toString()}");
      index++;
    });
    if (index == 1) print("<EMPTY LIST>");
  }

  // choisir une tâche (return an index)
  int choose_task() {
    displayTodoList();
    return chooseIndex(
      tasksList,
      "Write the task number: ",
      "Invalid choice !",
    );
  }

  // ajouter une nouvelle tâche
  void addTask() {
    Task? new_task = Task.createTask();
    if (new_task != null) {
      tasksList.add(new_task);
      print("New task added successfully");
    } else
      print("Action canceled");
  }

  // afficher les détails d'une tâche spécifique
  void displayTask() {
    int index = choose_task();
    if (index >= 0) {
      tasksList[index].display();
    } else {
      if (index == EMPTY_LIST) print("No task to display");
      if (index == CANCELED) print("Action canceled");
    }
  }

  // marquer une tâche comme terminée
  void markTaskAsDone() {
    int index = choose_task();
    if (index >= 0) {
      tasksList[index].markAsDone();
      print("Task successfully marked as done");
    } else {
      if (index == EMPTY_LIST) print("No task to mark as done");
      if (index == CANCELED) print("Action canceled");
    }
  }

  // modifier une tâche
  void updateTask() {
    int index = choose_task();
    if (index >= 0) {
      tasksList[index].update();
      print("Task successfully updated");
    } else {
      if (index == EMPTY_LIST) print("No task to update");
      if (index == CANCELED) print("Action canceled");
    }
  }

  // retirer une tâche
  void removeTask() {
    int index = choose_task();
    if (index >= 0) {
      Task task = tasksList.removeAt(index);
      print("Task «${task.title}» successfully removed");
    } else {
      if (index == EMPTY_LIST) print("No task to remove (your list is empty)");
      if (index == CANCELED) print("Action canceled");
    }
  }

  // sauvegarder l'état de la liste dans un fichier
  bool save(String path) {
    try {
      File file = new File(path);
      if (!file.existsSync()) {
        file.createSync(); // Créer un fichier vide
      }
      List<Map> tasks_json = [for (Task task in tasksList) task.toMap()];
      file.writeAsStringSync(jsonEncode(tasks_json));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static TodoList load(String path) {
    try {
      File file = new File(path);

      if (!file.existsSync()) {
        file.createSync(); // Créer un fichier vide
        return new TodoList([]);
      }
      String file_content = file.readAsStringSync();
      List<Map> tasks_json = List<Map>.from(jsonDecode(file_content));
      List<Task> tasksList = [
        for (Map task_map in tasks_json) Task.mapToTask(task_map),
      ];
      return new TodoList(tasksList);
    } catch (e) {
      print(e);
      return new TodoList([]);
    }
  }
}
