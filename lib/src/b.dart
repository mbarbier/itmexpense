part of b;

class B  {
  
  static B _b;
  static NodeTreeSanitizer treeSanitizer;
  
  static B get() {
    if (_b == null) {
      _b = new B._create();
    }
    return _b;
  }
  
  B._create() {
    bootjack.Bootjack.useDefault();
    treeSanitizer = new NullTreeSanitizer();
  }
  
  static Button newButton(String text) {
    return new Button(text);
  }

  static Modal newModal(String title) {
    Modal m = new Modal();
    m.title(title);
    
    final HtmlElement body = document.query('body');
    body.append(m.element);
    
    return m;
  }
 
  
  static pullr(Element e) {
    e.classes.add("pull-right");
    return e;
  }
}

class NullTreeSanitizer implements NodeTreeSanitizer {
  void sanitizeTree(Node node) {
  }
}