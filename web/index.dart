import 'dart:html';

import '../lib/b.dart';

void main() {
  B b = B.get();

  final HtmlElement body = document.query('body');
  
  Modal modal = B.newModal("Test de popup");
  modal.addToBody(new Element.html("<div>This an awesome popup</div>"));
  modal.addToBody(new Element.html("<div>I like it !</div>"));
  
  Button bn = B.newButton("normal");
  Button bp = B.newButton("primary")
    ..primary();
  
  bn.element.onClick.listen((e){
    modal.bj.show();
    });
  
  Element container = new Element.html("<div class=\"wrapper\"></div>");
  Row r1 = new Row();
  DivElement c1_1 = r1.addCol(md: 6);
  DivElement c1_2 = r1.addCol(md: 6);
  container.append(r1.element);
  body.append(container);
  
  c1_1.append(new Element.html("<p>Welcome to itmexpense</p>"));
  c1_2.append(bn.element);
  c1_2.append(bp.element);
}
