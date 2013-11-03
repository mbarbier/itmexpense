part of gwt;

class DockLayoutPanel {

  Map<Element, LayoutData> layoutDataByElement = new Map();
  List<Element> children = new List();
  
  Element _element;
  Unit _unit;
  Element _center;
  Layout _layout;
  double _filledWidth = 0.0;
  double _filledHeigh = 0.0;

  DockLayoutPanel(this._unit) {
    _element = new DivElement();
    _layout = new Layout(_element);
    
    // ?
    _layout.fillParent();
  }

  Element element() => _element;
  
  void add(Element e) {
    _insert(e, DockLayoutConstant.CENTER, 0.0, null);
  }

  void addEast(Element e, double size) {
    _insert(e, DockLayoutConstant.EAST, size, null);
  }

  void addLineEnd(Element e, double size) {
    _insert(e, DockLayoutConstant.LINE_END, size, null);
  }

  void addLineStart(Element e, double size) {
    _insert(e, DockLayoutConstant.LINE_START, size, null);
  }

  void addNorth(Element e, double size) {
    _insert(e, DockLayoutConstant.NORTH, size, null);
  }

  void addSouth(Element e, double size) {
    _insert(e, DockLayoutConstant.SOUTH, size, null);
  }

  void addWest(Element e, double size) {
    _insert(e, DockLayoutConstant.WEST, size, null);
  }

  void insertEast(Element e, double size, Element before) {
    _insert(e, DockLayoutConstant.EAST, size, before);
  }

  void insertLineEnd(Element e, double size, Element before) {
    _insert(e, DockLayoutConstant.LINE_END, size, before);
  }

  void insertLineStart(Element e, double size, Element before) {
    _insert(e, DockLayoutConstant.LINE_START, size, before);
  }

  void insertNorth(Element e, double size, Element before) {
    _insert(e, DockLayoutConstant.NORTH, size, before);
  }

  void insertSouth(Element e, double size, Element before) {
    _insert(e, DockLayoutConstant.SOUTH, size, before);
  }

  void insertWest(Element e, double size, Element before) {
    _insert(e, DockLayoutConstant.WEST, size, before);
  }

  void _insert(Element e, DockLayoutConstant direction, double size, Element before) {
    assertIsChild(before);

    // Validation.
    if (before == null) {
      assert (_center == null); // : "No widget may be added after the CENTER widget";
    } else {
      assert (direction != DockLayoutConstant.CENTER); // : "A CENTER widget must always be added last";
    }

    if (before == null) {
      _element.children.add(e);
      children.add(e);
    } else {
      int index = _element.children.indexOf(before);
      _element.children.insert(index, e);
      children.insert(index, e);
    }

    if (direction == DockLayoutConstant.CENTER) {
      _center = e;
    }

    Layer layer = _layout.attachChild(e, before:((before != null) ? before : null), userObject:e);
    
    LayoutData data = new LayoutData(direction, size, layer);
    _setLayoutData(e, data);

    // Update the layout.
    animate(0);
  }
  
  void animate(int duration) {
    // TODO schedule draw
    forceLayout();
  }

  void forceLayout() {
    _doLayout();
    _layout.layout();
  }

  
  void _setLayoutData(Element child, LayoutData data) {
    layoutDataByElement[child] = data;
  }
   
  LayoutData _getLayoutData(Element child, {bool remove: false}) {
    return layoutDataByElement[child];
  }
  
  Element getWidgetContainerElement(Element child) {
    assertIsChild(child);
    
    LayoutData layoutData = _getLayoutData(child);
    return layoutData.layer.getContainerElement();
  }

  DockLayoutConstant getWidgetDirection(Element child) {
    assertIsChild(child);
    if (child.parent != _element) {
      return null;
    }
    
    LayoutData layoutData = _getLayoutData(child);
    return layoutData.direction;
  }

  double getWidgetSize(Element child) {
    assertIsChild(child);
    if (child.parent != _element) {
      return null;
    }
    
    LayoutData layoutData = _getLayoutData(child);
    return layoutData.size;
  }

  bool remove(Element w) {
    bool removed = _element.children.remove(w);
    if (removed) {
      if (w == _center) {
        _center = null;
      }

      LayoutData layoutData = _getLayoutData(w, remove:true);
      _layout.removeChild(layoutData.layer);
    }

    return removed;
  }

  void setWidgetHidden(Element e, bool hidden) {
    assertIsChild(e);

    LayoutData data = _getLayoutData(e);
    if (data.hidden == hidden) {
      return;
    }

    data.hidden = hidden;
    animate(0);
  }

  void setWidgetSize(Element e, double size) {
    assertIsChild(e);
    LayoutData data = _getLayoutData(e);

    assert (data.direction != DockLayoutConstant.CENTER); // : "The size of the center widget can not be updated.";

    data.size = size;

    // Update the layout.
    animate(0);
  }

  Element getCenter() {
    return _center;
  }

  double getCenterHeight() {
    return _element.client.height / _layout.getUnitSize(_unit, true) - _filledHeigh;
  }

  double getCenterWidth() {
    return _element.client.width / _layout.getUnitSize(_unit, false) - _filledWidth;
  }

  DockLayoutConstant getResolvedDirection(DockLayoutConstant direction) {
    if (direction == DockLayoutConstant.LINE_START) {
      return DockLayoutConstant.WEST;
    } else if (direction == DockLayoutConstant.LINE_END) {
      return DockLayoutConstant.EAST;
    }
    return direction;
  }

  Unit getUnit() {
    return _unit;
  }

  void assertIsChild(Element e) {
    if(e == null) return;
    
    LayoutData data = _getLayoutData(e);
    if(data == null) return;
    
    Element child = data.layer.container;
    
    assert ((child == null) || (child.parent == _element)); // : "The specified widget is not a child of this panel";
  }

  void _doLayout() {
    double left = 0.0;
    double top = 0.0;
    double right = 0.0;
    double bottom = 0.0;

    for (Element child in children) {
      LayoutData data = _getLayoutData(child);
      Layer layer = data.layer;

      if (data.hidden) {
        layer.setVisible(false);
        continue;
      }

      switch (getResolvedDirection(data.direction)) {
        case DockLayoutConstant.NORTH:
          layer.setLeftRight(left, _unit, right, _unit);
          layer.setTopHeight(top, _unit, data.size, _unit);
          top += data.size;
          break;

        case DockLayoutConstant.SOUTH:
          layer.setLeftRight(left, _unit, right, _unit);
          layer.setBottomHeight(bottom, _unit, data.size, _unit);
          bottom += data.size;
          break;

        case DockLayoutConstant.WEST:
          layer.setTopBottom(top, _unit, bottom, _unit);
          layer.setLeftWidth(left, _unit, data.size, _unit);
          left += data.size;
          break;

        case DockLayoutConstant.EAST:
          layer.setTopBottom(top, _unit, bottom, _unit);
          layer.setRightWidth(right, _unit, data.size, _unit);
          right += data.size;
          break;

        case DockLayoutConstant.CENTER:
          layer.setLeftRight(left, _unit, right, _unit);
          layer.setTopBottom(top, _unit, bottom, _unit);
          break;
      }

      // First set the size, then ensure it's visible
      layer.setVisible(true);
    }

    _filledWidth = left + right;
    _filledHeigh = top + bottom;
  }
}

class LayoutData {
  DockLayoutConstant direction;
  double oldSize, size;
  double originalSize;
  bool hidden = false;
  Layer layer;

  LayoutData(this.direction, this.size, this.layer);
}
