part of b;

class Navbar {
  
  static text(Element e) {e.classes.add("navbar-text"); return e; }
  static leftAlign(Element e)  {e.classes.add("navbar-left"); return e;}
  static rightAlign(Element e)  {e.classes.add("navbar-right"); return e;}
  static brand(Element e) {e.classes.add("navbar-brand"); return e;}

  Element element;
  
  Navbar() {
    element = new Element.tag("nav")
     ..classes.add("navbar");
  }
  
  defaultn() => element.classes.add("navbar-default");
  inverse() => element.classes.add("navbar-inverse");
  staticTop() => element.classes.add("navbar-static-top");
  

  append(Element e) => element.append(e);
  
  DivElement addHeader() {
    DivElement header = new DivElement()
      ..classes.add("navbar-header");
    element.append(header);
    return header;
  }
}