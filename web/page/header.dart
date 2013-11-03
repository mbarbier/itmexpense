library header;

import 'dart:html';

import '../../lib/ui.dart';
import '../../lib/b.dart';

class HeaderWidget extends AbstractWidget {
  
  Navbar navbar;

  HeaderWidget(){
    navbar = new Navbar()
    ..staticTop()
    ..inverse()
    ..append(Navbar.rightAlign(Navbar.text(new Element.html("<p>R</p>"))))
    ..append(Navbar.brand(new Element.html("<b>itmeXpense</b>")));
  }
  
  Element element() {
    return navbar.element;
  }
  
  void onFirstShow() {
  }
  
}