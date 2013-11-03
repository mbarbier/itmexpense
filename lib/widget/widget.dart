part of ui;

abstract class Widget {
  
  void show();
  void leave();
  
  Element element();
  
}

abstract class AbstractWidget implements Widget {
  
  bool _started = false;
  bool shown = false;
  
  void show() {
    
    shown = true;
    
    if(!_started) {
      _started = true;
      onFirstShow();
    }
    
    onShow();
  }
  
  void leave() {
    shown = false;
    onLeave();
  }
  
  void onFirstShow() {
  }
  
  void onShow(){
  }

  void onLeave(){
  }

}