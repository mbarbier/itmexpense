part of ui;

class Button {
  
  ButtonElement element;
  
  Button(String text) {
    element = new ButtonElement()
     ..text=text
     ..classes.add("btn");
  }
  
  void primary() {
    element.classes.add("btn-primary");
  }
  
  void success() {
    element.classes.add("btn-success");
  }
  
  void info() {
    element.classes.add("btn-info");
  }
  
  void warning() {
    element.classes.add("btn-warning");
  }
  
  void danger() {
    element.classes.add("btn-danger");
  }
  
}
