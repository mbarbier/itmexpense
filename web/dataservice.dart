library dataservice;

import '../lib/model.dart';
import 'dart:html';
import 'dart:convert';

class DataService  {
  
  static DataService _instance;
  
  List<Account> _accounts;
  
  factory DataService() {
    if (_instance == null) {
      _instance = new DataService._create();
    }
    return _instance;
  }
  
  DataService._create() {
  }
  
  List<Account> getAccounts() {
    if(_accounts == null) _loadAccounts();
    
    return _accounts;
  }
  
  void addAccount(Account account) {
    getAccounts().add(account);

    String accountAsString = JSON.encode(_accounts);
    window.console.log("Saving accounts #" + accountAsString);
    window.localStorage["accounts"] = accountAsString;
  }
  
  _loadAccounts() {
    String accountsAsJson = window.localStorage["accounts"];
    if(accountsAsJson != null) {
      _accounts = JSON.decode(accountsAsJson);
    } else {
      _accounts = new List<Account>();
    }
  }
  
}

