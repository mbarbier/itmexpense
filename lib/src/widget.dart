part of ui;

abstract class Widget {
  
  void onFirstShow();
  void onShow();
  void onLeave();

  Element element();
  
}