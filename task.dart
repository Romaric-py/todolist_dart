import 'utils.dart';

class Task {
  String title;
  String description;
  String due_date;
  bool status;

  // Constructeur
  Task(this.title, this.description, this.due_date, this.status);

  // Affichage simplifié de la tâche
  String toString() {
    return "${this.status ? '✅' : '❌'} ${this.title} (${this.due_date})";
  }

  // Affichage de tous les détails de la tâches
  void display() {
    animatedPrint(
      "\nTitle: ${this.title} \nDescription: ${this.description} \nDue Date: ${this.due_date} \nStatus: ${this.status ? '✅ Done' : '❌Not done'} \n",
    );
  }

  // Transformer en objet json sous forme de chaine de caractère
  Map toMap() {
    Map task_map = {
      'title': title,
      'description': description,
      'due_date': due_date,
      'status': status,
    };
    return task_map;
  }

  // Marquer la tâche comme accomplie
  void markAsDone() {
    this.status = true;
    print("Marked as done");
  }

  // Modifier une tâche // TODO
  void update() {
    String? new_title = askUntil(
      "Title (required)",
      isNotEmptyString,
      "The title mustn't be empty",
    );
    if (isNotEmptyString(new_title)) title = new_title!;

    String new_description =
        (input("Description (optional): ") ?? "").toString();
    if (isNotEmptyString(new_description)) description = new_description;

    String? new_due_date = askUntil(
      "Due Date (jj/mm/aaaa)",
      isValidDate,
      "Date not in right format",
    );
    if (isNotEmptyString(new_due_date)) due_date = new_due_date!;

    int statusInt = chooseIndex(
      ["Not done", "Done"],
      "Status: (1 for 'Not done', 2 for 'Done')",
      "Invalid input !!",
    );
    if (statusInt >= 0) status = (statusInt == 1);
  }
  // leave field blank for no change

  // créer une nouvelle tâche
  static Task? createTask() {
    String? title = askUntil(
      "Title (required)",
      isNotEmptyString,
      "The title mustn't be empty",
    );
    if (title == null) return null;

    String description = (input("Description (optional): ") ?? "").toString();

    String? due_date = askUntil(
      "Due Date (jj/mm/aaaa)",
      isValidDate,
      "Date not in right format",
    );
    if (due_date == null) return null;

    bool status = false;

    return new Task(title, description, due_date, status);
  }

  //  créer une nouvelle tâche à partir d'une map
  static Task mapToTask(Map task_map) {
    return new Task(
      task_map["title"],
      task_map["description"],
      task_map["due_date"],
      task_map["status"],
    );
  }
}
