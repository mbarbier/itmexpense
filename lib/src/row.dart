part of ui;

class Row {
  
  DivElement element;
  
  Row() {
    element = new DivElement()
     ..classes.add("row");
  }
  
  DivElement addCol({int xs, int sm, int md, int lg}) {
    DivElement c = new DivElement();
    if(xs != null) c.classes.add("col-xs-"+xs.toString());
    if(sm != null) c.classes.add("col-sm-"+sm.toString());
    if(md != null) c.classes.add("col-md-"+md.toString());
    if(lg != null) c.classes.add("col-lg-"+lg.toString());
    element.append(c);
    return c;
  }
}