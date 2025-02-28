import 'dart:io';

String? input(String prompt) {
  /// A function for getting information from user based on a given prompt
  stdout.write(prompt);
  String? user_input = stdin.readLineSync();
  return user_input;
}

class DistributeurDeSamuel {
  List<String> drinks;
  List<double> prices;

  // constructeur
  DistributeurDeSamuel(this.drinks, this.prices);

  // démarrer
  void start() {
    print("Bienvenue au distributeur !");
    this.displayAllDrinks();
  }

  void displayAllDrinks() {
    int num_drinks = this.drinks.length;
    if (num_drinks == 0) {
      print("Le distributeur est vide.");
    } else {
      print("\nVoici les produits disponibles");
      for (int i = 0; i < num_drinks; i++) {
        print("${i + 1} ${this.drinks[i]} - ${this.prices[i]}€");
      }
    }
  }

  void buy() {
    print("Choisir le produit souhaité");
    int index = get_choice();
    String drink = this.drinks[index];
    double price = this.prices[index];

    print("Vous avez choisi ${drink} - ${price}€\n");

    // choix de la quantité
    int quantity = get_quantity();

    // Paiement
    double total_price = quantity * price;

    print("Vous devez payer ${total_price}€\n");

    double montant = get_money();

    if (total_price <= montant) {
      print("Voici votre reliquat: ${montant - total_price}");
    } else {
      print("Montant insuffisant!! ");
    }
  }

  int get_quantity() {
    // display all tasks
    String? q;

    // ask for a number until it is valid
    do {
      q = input("Entrer la quantité: ");
      if (!isInt(q)) {
        print("Entrée invalide");
      }
    } while ((!isInt(q)));
    return int.parse(q.toString());
  }

  double get_money() {
    // display all tasks
    String? m;

    // ask for a number until it is valid
    do {
      m = input("Entrer votre somme :");
      if (!isDouble(m)) {
        print("Entrée invalide");
      }
    } while ((!isDouble(m)));
    return double.parse(m.toString());
  }

  int get_choice() {
    // display all tasks
    String? index;
    int len = this.drinks.length;

    // ask for a number until it is valid
    do {
      index = input("Choose a number: ");
      if (!checkIndice(index, len)) {
        print("Le numéro entré est incorrect");
      }
    } while ((!checkIndice(index, len)));
    return int.parse(index.toString()) - 1;
  }

  bool checkIndice(String? index, int list_length) {
    if (index != null && index.isNotEmpty) {
      int? number = int.tryParse(index);
      if (number != null) {
        return ((0 < number) && (number <= list_length));
      }
    }
    return false;
  }

  bool isDouble(String? str) {
    if (str != null && str.isNotEmpty) {
      double? number = double.tryParse(str);
      if (number != null) {
        return true;
      }
    }
    return false;
  }

  bool isInt(String? str) {
    if (str != null && str.isNotEmpty) {
      int? number = int.tryParse(str);
      if (number != null) {
        return true;
      }
    }
    return false;
  }
}

/// Démarrer: bienvenue + afficher le menu
/// Une méthode pour afficher le menu
/// une méthode pour démarrer le paiement
/// traiter le choix

void main() {
  List<String> drinks = ["Coca-cola", "Fanta", "Café", "Chips"];

  List<double> prices = [1.8, 1.5, 0.5, 1.05];

  var distributeur = new DistributeurDeSamuel(drinks, prices);
  distributeur.start();
  distributeur.buy();
}
