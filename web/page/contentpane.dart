library header;

import 'dart:html';

import '../../lib/ui.dart';

class ContentPaneWidget extends AbstractWidget {
  
  DivElement _container;

  ContentPaneWidget(){
    _container = new DivElement();
  }
  
  Element element() {
    return _container;
  }
  
  void onFirstShow() {
    _container.append(new Element.html("<p>The content pane</p>"));
  }
  
}