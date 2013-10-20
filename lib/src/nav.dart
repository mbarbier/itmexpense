part of ui;

class Navbar {
  
  Element element;
  DivElement header;
  
  Navbar() {
    element = new Element.tag("nav")
     ..classes.add("navbar");
  }
  
  defaultn() => element.classes.add("navbar-default");
  inverse() => element.classes.add("navbar-inverse");
  staticTop() => element.classes.add("navbar-static-top");
  
  text(Element e) => e.classes.add("navbar-text");
  leftAlign(Element e) => e.classes.add("navbar-left");
  rightAlign(Element e) => e.classes.add("navbar-right");

  brand(Element e) => e.classes.add("navbar-brand");
  
  withHeader() {
    header = new DivElement()
      ..classes.add("navbar-header");
  }
}