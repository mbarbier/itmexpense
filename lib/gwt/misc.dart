part of gwt;

class Unit {
  final String _value;
  const Unit._internal(this._value);
  
  String value() => _value;
  toString() => 'Unit.$_value';

  static const Unit PX = const Unit._internal("px");
  static const Unit PCT = const Unit._internal("%");
  static const Unit EM = const Unit._internal("em");
  static const Unit EX = const Unit._internal("ex");
  static const Unit PT = const Unit._internal("pt");
  static const Unit PC = const Unit._internal("pc");
  static const Unit IN = const Unit._internal("in");
  static const Unit CM = const Unit._internal("cm");
  static const Unit MM = const Unit._internal("mm");
}

class Alignment {

  final String _value;
  const Alignment._internal(this._value);
  
  String value() => _value;
  toString() => 'Alignment.$_value';

  static const Alignment BEGIN = const Alignment._internal("BEGIN");
  static const Alignment END = const Alignment._internal("END");
  static const Alignment STRETCH = const Alignment._internal("STRETCH");
}

class DockLayoutConstant {

  final int _value;
  const DockLayoutConstant._internal(this._value);
  
  int value() => _value;
  toString() => 'DockLayoutConstant.$_value';
  
  static const DockLayoutConstant CENTER = const DockLayoutConstant._internal(0);
  static const DockLayoutConstant LINE_START = const DockLayoutConstant._internal(1);
  static const DockLayoutConstant LINE_END = const DockLayoutConstant._internal(2);
  static const DockLayoutConstant EAST = const DockLayoutConstant._internal(3);
  static const DockLayoutConstant NORTH = const DockLayoutConstant._internal(4);
  static const DockLayoutConstant SOUTH = const DockLayoutConstant._internal(5);
  static const DockLayoutConstant WEST = const DockLayoutConstant._internal(6);
}