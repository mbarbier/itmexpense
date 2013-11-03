part of gwt;

class LayoutImpl {

  static DivElement fixedRuler;
  static bool _initialised = false;

  factory LayoutImpl.browserDependent() {
    if (!_initialised) {
      _initialised = true;
      fixedRuler = createRuler(Unit.CM, Unit.CM);
      document.body.append(fixedRuler);
    }
    return new LayoutImpl._internal();
  }

  static DivElement createRuler(Unit widthUnit, Unit heightUnit) {
    DivElement ruler = new DivElement();
    ruler.innerHtml = "&nbsp;";
    ruler.style.position = "absolute";
    ruler.style.zIndex = "-32767";

    ruler.style.top = "-20" + heightUnit.value();

    ruler.style.width = "10" + widthUnit.value();
    ruler.style.height = "10" + heightUnit.value();
    return ruler;
  }

  LayoutImpl._internal();

  DivElement relativeRuler;

  Element attachChild(Element parent, Element child, Element before) {
    DivElement container = new DivElement();
    container.append(child);

    container.style.position = "absolute";
    container.style.overflow = "hidden";
    container.style.left = "0" + Unit.PX.value();
    container.style.top = "0" + Unit.PX.value();
    container.style.right = "0" + Unit.PX.value();
    container.style.bottom = "0" + Unit.PX.value();

    fillParent(child);

    Element beforeContainer = null;
    if (before != null) {
      beforeContainer = before.parent;
      assert (beforeContainer.parent == parent); // : "Element to insert before must be a sibling";
    }
    parent.insertBefore(container, beforeContainer);
    return container;
  }

  void fillParent(Element elem) {
    elem.style.position = "absolute";
    elem.style.left = "0" + Unit.PX.value();
    elem.style.top = "0" + Unit.PX.value();
    elem.style.right = "0" + Unit.PX.value();
    elem.style.bottom = "0" + Unit.PX.value();
  }

  void finalizeLayout(Element parent) {
  }

  double getUnitSizeInPixels(Element parent, Unit unit, bool vertical) {
    if (unit == null) {
      return 1.0;
    }

    switch (unit) {
      case Unit.PCT:
        return (vertical ? parent.client.height : parent.client.width) / 100.0;
      case Unit.EM:
        return relativeRuler.offset.width / 10.0;
      case Unit.EX:
        return relativeRuler.offset.height / 10.0;
      case Unit.CM:
        return fixedRuler.offset.width * 0.1; // 1.0 cm / cm
      case Unit.MM:
        return fixedRuler.offset.width * 0.01; // 0.1 cm / mm
      case Unit.IN:
        return fixedRuler.offset.width * 0.254; // 2.54 cm / in
      case Unit.PT:
        return fixedRuler.offset.width * 0.00353; // 0.0353 cm / pt
      case Unit.PC:
        return fixedRuler.offset.width * 0.0423; // 0.423 cm / pc

      case Unit.PX:
      default:
        return 1.0;
    }
  }

  void initParent(Element parent) {
    parent.style.position = "relative";
    //parent.append(relativeRuler = createRuler(Unit.EM, Unit.EX));
  }

  void layout(Layer layer) {
    if (layer.visible) {
      layer.container.style.display = "";
    } else {
      layer.container.style.display = "none";
    }

    layer.container.style.left = layer.setLeft ? (layer.left.toString() + layer.leftUnit.value()) : "";
    layer.container.style.top = layer.setTop ? (layer.top.toString() + layer.topUnit.value()) : "";
    layer.container.style.right = layer.setRight ? (layer.right.toString() + layer.rightUnit.value()) : "";
    layer.container.style.bottom = layer.setBottom ? (layer.bottom.toString() + layer.bottomUnit.value()) : "";
    layer.container.style.width = layer.setWidth ? (layer.width.toString() + layer.widthUnit.value()) : "";
    layer.container.style.height = layer.setHeight ? (layer.height.toString() + layer.heightUnit.value()) : "";

    switch (layer.hPos) {
      case Alignment.BEGIN:
        layer.child.style.left = "0" + Unit.PX.value();
        layer.child.style.right = "";
        break;
      case Alignment.END:
        layer.child.style.left = "";
        layer.child.style.right = "0" + Unit.PX.value();
        break;
      case Alignment.STRETCH:
        layer.child.style.left = "0" + Unit.PX.value();
        layer.child.style.right = "0" + Unit.PX.value();
        break;
    }

    switch (layer.vPos) {
      case Alignment.BEGIN:
        layer.child.style.top = "0" + Unit.PX.value();
        layer.child.style.bottom = "";
        break;
      case Alignment.END:
        layer.child.style.top = "";
        layer.child.style.bottom = "0" + Unit.PX.value();
        break;
      case Alignment.STRETCH:
        layer.child.style.top = "0" + Unit.PX.value();
        layer.child.style.bottom = "0" + Unit.PX.value();
        break;
    }
  }

  void removeChild(Element container, Element child) {
    container.remove();

    if (child.parent == container) {
      child.remove();
    }

    child.style.position = "";
    child.style.left = "";
    child.style.top = "";
    child.style.width = "";
    child.style.height = "";
  }
}
