part of gwt;

class Layout {

  LayoutImpl impl = new LayoutImpl.browserDependent();

  List<Layer> layers = new List<Layer>();
  Element parentElem;

  Layout(Element parent) {
    this.parentElem = parent;
    impl.initParent(parent);
  }

  void assertIsChild(Element elem) {
    assert (elem.parent.parent == this.parentElem);
  }

  Layer attachChild(Element child, {Element before:null, Object userObject}) {
    Element container = impl.attachChild(parentElem, child, before);
    Layer layer = new Layer(container, child, userObject);
    layers.add(layer);
    return layer;
  }

  void fillParent() {
    impl.fillParent(parentElem);
  }

  double getUnitSize(Unit unit, bool vertical) {
    return impl.getUnitSizeInPixels(parentElem, unit, vertical);
  }

  void layout([int duration = 0]) {
    
    for (Layer l in layers) {
      l.left = l.sourceLeft = l.targetLeft;
      l.top = l.sourceTop = l.targetTop;
      l.right = l.sourceRight = l.targetRight;
      l.bottom = l.sourceBottom = l.targetBottom;
      l.width = l.sourceWidth = l.targetWidth;
      l.height = l.sourceHeight = l.targetHeight;

      l.setLeft = l.setTargetLeft;
      l.setTop = l.setTargetTop;
      l.setRight = l.setTargetRight;
      l.setBottom = l.setTargetBottom;
      l.setWidth = l.setTargetWidth;
      l.setHeight = l.setTargetHeight;

      l.leftUnit = l.targetLeftUnit;
      l.topUnit = l.targetTopUnit;
      l.rightUnit = l.targetRightUnit;
      l.bottomUnit = l.targetBottomUnit;
      l.widthUnit = l.targetWidthUnit;
      l.heightUnit = l.targetHeightUnit;

      impl.layout(l);
    }

    impl.finalizeLayout(parentElem);
  }

  void removeChild(Layer layer) {
    impl.removeChild(layer.container, layer.child);
    int indx = layers.indexOf(layer);
    if (indx != -1) {
      layers.removeAt(indx);
    }
  }

  void adjustHorizontalConstraints(int parentWidth, Layer l) {
    double leftPx = l.left * getUnitSize(l.leftUnit, false);
    double rightPx = l.right * getUnitSize(l.rightUnit, false);
    double widthPx = l.width * getUnitSize(l.widthUnit, false);

    if (l.setLeft && !l.setTargetLeft) {
      // -left
      l.setLeft = false;

      if (!l.setWidth) {
        // +width
        l.setTargetWidth = true;
        l.sourceWidth = (parentWidth - (leftPx + rightPx))
            / getUnitSize(l.targetWidthUnit, false);
      } else {
        // +right
        l.setTargetRight = true;
        l.sourceRight = (parentWidth - (leftPx + widthPx))
            / getUnitSize(l.targetRightUnit, false);
      }
    } else if (l.setWidth && !l.setTargetWidth) {
      // -width
      l.setWidth = false;

      if (!l.setLeft) {
        // +left
        l.setTargetLeft = true;
        l.sourceLeft = (parentWidth - (rightPx + widthPx))
            / getUnitSize(l.targetLeftUnit, false);
      } else {
        // +right
        l.setTargetRight = true;
        l.sourceRight = (parentWidth - (leftPx + widthPx))
            / getUnitSize(l.targetRightUnit, false);
      }
    } else if (l.setRight && !l.setTargetRight) {
      // -right
      l.setRight = false;

      if (!l.setWidth) {
        // +width
        l.setTargetWidth = true;
        l.sourceWidth = (parentWidth - (leftPx + rightPx))
            / getUnitSize(l.targetWidthUnit, false);
      } else {
        // +left
        l.setTargetLeft = true;
        l.sourceLeft = (parentWidth - (rightPx + widthPx))
            / getUnitSize(l.targetLeftUnit, false);
      }
    }

    l.setLeft = l.setTargetLeft;
    l.setRight = l.setTargetRight;
    l.setWidth = l.setTargetWidth;

    l.leftUnit = l.targetLeftUnit;
    l.rightUnit = l.targetRightUnit;
    l.widthUnit = l.targetWidthUnit;
  }

  void adjustVerticalConstraints(int parentHeight, Layer l) {
    double topPx = l.top * getUnitSize(l.topUnit, true);
    double bottomPx = l.bottom * getUnitSize(l.bottomUnit, true);
    double heightPx = l.height * getUnitSize(l.heightUnit, true);

    if (l.setTop && !l.setTargetTop) {
      // -top
      l.setTop = false;

      if (!l.setHeight) {
        // +height
        l.setTargetHeight = true;
        l.sourceHeight = (parentHeight - (topPx + bottomPx))
            / getUnitSize(l.targetHeightUnit, true);
      } else {
        // +bottom
        l.setTargetBottom = true;
        l.sourceBottom = (parentHeight - (topPx + heightPx))
            / getUnitSize(l.targetBottomUnit, true);
      }
    } else if (l.setHeight && !l.setTargetHeight) {
      // -height
      l.setHeight = false;

      if (!l.setTop) {
        // +top
        l.setTargetTop = true;
        l.sourceTop = (parentHeight - (bottomPx + heightPx))
            / getUnitSize(l.targetTopUnit, true);
      } else {
        // +bottom
        l.setTargetBottom = true;
        l.sourceBottom = (parentHeight - (topPx + heightPx))
            / getUnitSize(l.targetBottomUnit, true);
      }
    } else if (l.setBottom && !l.setTargetBottom) {
      // -bottom
      l.setBottom = false;

      if (!l.setHeight) {
        // +height
        l.setTargetHeight = true;
        l.sourceHeight = (parentHeight - (topPx + bottomPx))
            / getUnitSize(l.targetHeightUnit, true);
      } else {
        // +top
        l.setTargetTop = true;
        l.sourceTop = (parentHeight - (bottomPx + heightPx))
            / getUnitSize(l.targetTopUnit, true);
      }
    }

    l.setTop = l.setTargetTop;
    l.setBottom = l.setTargetBottom;
    l.setHeight = l.setTargetHeight;

    l.topUnit = l.targetTopUnit;
    l.bottomUnit = l.targetBottomUnit;
    l.heightUnit = l.targetHeightUnit;
  }
}


class Layer {
  Element container, child;
  Object userObject;

  bool setLeft = false, setRight = false, setTop = false, setBottom = false, setWidth = false, setHeight = false;
  bool setTargetLeft = true, setTargetRight = true, setTargetTop = true,
      setTargetBottom = true, setTargetWidth = false, setTargetHeight = false;
  Unit leftUnit, topUnit, rightUnit, bottomUnit, widthUnit, heightUnit;
  Unit targetLeftUnit = Unit.PX, targetTopUnit = Unit.PX, targetRightUnit = Unit.PX,
      targetBottomUnit = Unit.PX, targetWidthUnit, targetHeightUnit;
  double left = 0.0, top = 0.0, right = 0.0, bottom = 0.0, width = 0.0, height = 0.0;
  double sourceLeft = 0.0, sourceTop = 0.0, sourceRight = 0.0, sourceBottom = 0.0, sourceWidth = 0.0,
  sourceHeight = 0.0;
  double targetLeft = 0.0, targetTop = 0.0, targetRight = 0.0, targetBottom = 0.0, targetWidth = 0.0,
  targetHeight = 0.0;

  Alignment hPos = Alignment.STRETCH, vPos = Alignment.STRETCH;
  bool visible = true;

  Layer(Element container, Element child, Object userObject) {
    this.container = container;
    this.child = child;
    this.userObject = userObject;
  }

  Element getContainerElement() {
    return container;
  }

  Object getUserObject() {
    return this.userObject;
  }

  void setBottomHeight(double bottom, Unit bottomUnit, double height,
                       Unit heightUnit) {
    this.setTargetBottom = this.setTargetHeight = true;
    this.setTargetTop = false;
    this.targetBottom = bottom;
    this.targetHeight = height;
    this.targetBottomUnit = bottomUnit;
    this.targetHeightUnit = heightUnit;
  }

  void setChildHorizontalPosition(Alignment position) {
    this.hPos = position;
  }

  void setChildVerticalPosition(Alignment position) {
    this.vPos = position;
  }

  void setLeftRight(double left, Unit leftUnit, double right,
                    Unit rightUnit) {
    this.setTargetLeft = this.setTargetRight = true;
    this.setTargetWidth = false;
    this.targetLeft = left;
    this.targetRight = right;
    this.targetLeftUnit = leftUnit;
    this.targetRightUnit = rightUnit;
  }

  void setLeftWidth(double left, Unit leftUnit, double width,
                    Unit widthUnit) {
    this.setTargetLeft = this.setTargetWidth = true;
    this.setTargetRight = false;
    this.targetLeft = left;
    this.targetWidth = width;
    this.targetLeftUnit = leftUnit;
    this.targetWidthUnit = widthUnit;
  }

  void setRightWidth(double right, Unit rightUnit, double width,
                     Unit widthUnit) {
    this.setTargetRight = this.setTargetWidth = true;
    this.setTargetLeft = false;
    this.targetRight = right;
    this.targetWidth = width;
    this.targetRightUnit = rightUnit;
    this.targetWidthUnit = widthUnit;
  }

  void setTopBottom(double top, Unit topUnit, double bottom,
                    Unit bottomUnit) {
    this.setTargetTop = this.setTargetBottom = true;
    this.setTargetHeight = false;
    this.targetTop = top;
    this.targetBottom = bottom;
    this.targetTopUnit = topUnit;
    this.targetBottomUnit = bottomUnit;
  }

  void setTopHeight(double top, Unit topUnit, double height,
                    Unit heightUnit) {
    this.setTargetTop = this.setTargetHeight = true;
    this.setTargetBottom = false;
    this.targetTop = top;
    this.targetHeight = height;
    this.targetTopUnit = topUnit;
    this.targetHeightUnit = heightUnit;
  }

  void setVisible(bool visible) {
    this.visible = visible;
  }
}
