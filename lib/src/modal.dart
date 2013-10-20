part of ui;

class Modal {

  DivElement _modal;
  DivElement _dialog;
  DivElement _content;
  DivElement _header;
  DivElement _body;
  DivElement _footer;
  
  Element _close;
  Element _title;
  
  bootjack.Modal bj;
  
  Modal() {
    _modal = new DivElement();
    _dialog = new DivElement();
    _content = new DivElement();
    _header = new DivElement();
    _body = new DivElement();
    _footer = new DivElement();
    
    _close = new Element.html("<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>", treeSanitizer : B.treeSanitizer);
    _title = new Element.tag("h4");
    
    _modal.classes.add("modal");
    _modal.classes.add("fade");
    _modal.tabIndex=-1;
    
    _dialog.classes.add("modal-dialog");
    _content.classes.add("modal-content");
    _header.classes.add("modal-header");
    _body.classes.add("modal-body");
    _footer.classes.add("modal-footer");
    
    _modal.append(_dialog);
    _dialog.append(_content);
    _content.append(_header);
    _content.append(_body);
    _content.append(_footer);
    
    _header.append(_close);
    _header.append(_title);
    
    bj = bootjack.Modal.wire(_modal);
  }
  
  title(String text) {
    _title.text=text;
  }
  addToBody(Element e) {
    _body.append(e);
  }
  addToFooter(Element e) {
    _footer.append(e);
  }
  
  Element get element => _modal;
  
}
