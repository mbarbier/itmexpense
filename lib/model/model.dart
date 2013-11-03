part of model;

class Account {
  String name;
  String num;
  double balance;
}

class Entry {
  DateTime date;
}

class App {
  List<Account> accounts = new List<Account>();
}
