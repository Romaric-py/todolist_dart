import 'dart:io';

const EMPTY_LIST = -1;
const CANCELED = -2;

bool isInt(String? exp) {
  return (exp != null && int.tryParse(exp) != null);
}

bool isDouble(String? exp) {
  return (exp != null && int.tryParse(exp) != null);
}

bool isNotEmptyString(String? exp) {
  return (exp != null && exp.trim().isNotEmpty);
}

bool isEmptyString(String? exp) {
  return !isNotEmptyString(exp);
}

//! Date format: JJ/MM/AAAA
bool isValidDate(String? exp) {
  String date = (exp ?? "");
  if (date.length != 10) return false;

  List<String> date_list = date.split('/');
  return ((date_list[0].length == 2 && isInt(date_list[0])) &&
      (date_list[1].length == 2 && isInt(date_list[1])) &&
      (date_list[2].length == 4 && isInt(date_list[2])));
}

bool isInRange(int x, int a, int b) {
  return (a <= x) && (x <= b);
}

String? input(String prompt) {
  /// A function for getting information from user based on a given prompt
  stdout.write(prompt);
  String? user_input = stdin.readLineSync();
  return user_input;
}

String? askUntil(
  String prompt,
  Function checker,
  String invalidInputMessage, [
  bool cancelable = true,
]) {
  /// A function for asking information from user
  String? user_input = input(
    prompt + (cancelable ? ' [type /q to cancel]: ' : ": "),
  );
  if (user_input == "/q" && cancelable) {
    return null;
  }
  if (!checker(user_input)) {
    print(invalidInputMessage);
    return askUntil(prompt, checker, invalidInputMessage, cancelable);
  }
  return user_input.toString();
}

int chooseIndex(
  List list,
  String prompt,
  String invalidInputMessage, [
  bool cancelable = true,
]) {
  if (list.length == 0) return EMPTY_LIST;

  Function checker =
      (String? exp) =>
          (isInt(exp) &&
              isInRange(
                int.parse(exp.toString()),
                1,
                list.length,
              )); // en comptant sur l'évaluation en court-circuit

  String? indexStr = askUntil(prompt, checker, invalidInputMessage, cancelable);
  return (indexStr != null) ? int.parse(indexStr) - 1 : CANCELED;
}

void animatedPrint(String object) {
  for (int i = 0; i < object.length; i++) {
    stdout.write(object[i]);
    sleep(Duration(milliseconds: 10));
  }
  stdout.write("\n");
}
