import 'dart:html';

import '../lib/b.dart';
import 'app.dart';

void main() {
  B b = B.get();

  final AppWidget app = new AppWidget();
  final HtmlElement body = document.querySelector('body');
  body.append(app.element());
  app.show();
}
