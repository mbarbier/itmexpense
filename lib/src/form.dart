part of b;

class Form {
  
  Element element;
  Element buttonsElement;
  
  Form() {
    element = new Element.tag("form");
  }
  
  horizontal() => element.classes.add("form-horizontal");

  DivElement addField(Field field) {
    element.append(field.groupElement);
    return field.groupElement;
  }
  
  addSubmit(String label, void onClick(MouseEvent e)) {
    if(buttonsElement == null) {
      buttonsElement = new Element.html("<div class=\"form-group\"></div>");
      element.append(buttonsElement);
    }
    
    Button btn = new Button(label);
    Element e = btn.element;
    btn.primary();
    e.onClick.listen((MouseEvent event) {
      event.preventDefault();
      onClick(event);
    });
    buttonsElement.append(B.pullr(e));
  }
  
  addCancel(String label, void onClick(MouseEvent e)) {
    if(buttonsElement == null) {
      buttonsElement = new Element.html("<div class=\"form-group\"></div>");
      element.append(buttonsElement);
    }
    
    Button btn = new Button(label);
    Element e = btn.element;
    e.onClick.listen((MouseEvent event) {
      event.preventDefault();
      onClick(event);
    });
    buttonsElement.append(B.pullr(e));
  }
}


class Field {
  
  static int gid=0;
  
  int captionWidth;
  bool horizontal;
  String id;
  Element inputElement;
  DivElement groupElement;
  Element captionElement;
  Element contentElement;
  
  Field(String caption, {bool horizontal: true, int captionWidth: 2}) {
    
    this.horizontal = horizontal;
    this.captionWidth = captionWidth;
    this.id = (gid++).toString();
    this.groupElement = new DivElement()..classes.add("form-group");
    this.captionElement = new Element.html("<label for=\""+id+"\" class=\"control-label\">"+caption+"</label>");
  
    this.groupElement.append(captionElement);
    
    if(horizontal){
      int inputWidth = 12 - captionWidth;
      this.contentElement = new DivElement()..classes.add("col-sm-"+inputWidth.toString());
      this.captionElement.classes.add("col-sm-"+captionWidth.toString());
      this.groupElement.append(contentElement);
    }
    
  }
  
  setInput(Element input) {
    this.inputElement = input;
    this.inputElement.classes.add("form-control");
    
    if(contentElement != null) contentElement.append(inputElement);
    else groupElement.append(inputElement);
    
    if(input.id != null) {
      captionElement.attributes["for"] = input.id;
    } else {
      input.id = id;
    }
  }
  
  factory Field.from(String caption, Element input,
      {bool horizontal: true, int captionWidth: 2}) {
    Field f = new Field(caption);
    f.setInput(input);
    return f;
  }
}