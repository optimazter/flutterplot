import 'dart:ui';

abstract class HittablePlotObject {

  HittablePlotObject({
    required this.width, 
    required this.height, 
    required this.coordinate,
    this.onDragStarted,
    this.onDragEnd});

  /// The width of the SizedBox which containts the [child]
  final double width;

  /// The height of the SizedBox which containts the [child]
  final double height;

  /// The Coordinate in the Plot space where the object is lcoated
  Offset? coordinate;

  /// Function called every time the object drag has started
  final Function(HittablePlotObject obj)? onDragStarted;

  /// Function called every time the object has been moved
  final Function(HittablePlotObject obj)? onDragEnd;



}