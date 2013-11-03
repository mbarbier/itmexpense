library header;

import 'dart:html';

import '../../lib/ui.dart';

class LeftPaneWidget extends AbstractWidget {
  
  DivElement _container;

  LeftPaneWidget(){
    _container = new DivElement();
  }
  
  Element element() {
    return _container;
  }
  
  void onFirstShow() {
    _container.append(new Element.html("<p>The left pane</p>"));
  }
  
}