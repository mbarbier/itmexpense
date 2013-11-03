library app;

import 'dart:html';

import '../lib/ui.dart';
import '../lib/b.dart';
import '../lib/model.dart';
import '../lib/gwt.dart';

import 'dataservice.dart';
import 'page/header.dart';
import 'page/leftpane.dart';
import 'page/contentpane.dart';

class AppWidget extends AbstractWidget {
  
  HeaderWidget headerWidget;
  LeftPaneWidget leftWidget;
  ContentPaneWidget contentWidget;
  DockLayoutPanel layout;
  Row r1;

  AppWidget(){
    r1 = new Row();
    layout = new DockLayoutPanel(Unit.EM);    
  }
  
  Element element() {
    return layout.element();
  }
  
  void onFirstShow() {
    
    headerWidget = new HeaderWidget();
    leftWidget = new LeftPaneWidget();
    contentWidget = new ContentPaneWidget();
    
    layout.addNorth(headerWidget.element(), 4.0);
    layout.addWest(leftWidget.element(), 35.0);
    layout.add(contentWidget.element());
    
    DataService service = new DataService();
    List<Account> accounts = service.getAccounts();
    if(accounts.isEmpty) {
      showCreateAccountForm();
    }
  }
  
  void onShow() {
    headerWidget.show();
    leftWidget.show();
    contentWidget.show();
  }
  
  showCreateAccountForm() {
    
    Form f = new Form();
    f.horizontal();
    
    f.addField(new Field.from("Name", new TextInputElement()));
    f.addField(new Field.from("Number", new TextInputElement()));
    f.addField(new Field.from("Balance", new NumberInputElement()..step=0.01.toString()));
    
    f.addSubmit("Create", (E){
      window.console.log("Account created");
    });
    f.addCancel("Cancel", (E){
      window.console.log("-- canceled --");
    });
    
    Modal modal = B.newModal("Add an account");
    modal.addToBody(f.element);
    modal.bj.show();
  }
  
}