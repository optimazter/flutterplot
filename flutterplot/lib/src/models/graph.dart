import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterplot/flutterplot.dart';
import 'package:flutterplot/src/utils/utils.dart';

/// A graph which can be painted in a FlutterPlot [Plot] object
/// 
/// The graph painted must be specified by the [x] and [y] parameters.
/// Note that [x] and [y] must be of equal length.

class Graph {

  const Graph({
    required this.x, 
    required this.y,
    this.color,
    this.annotations,
    this.crosshairs, 
  }) : 
  assert(x.length == y.length, 'Graph [x] and [y] must be of equal length, but found ${x.length} x-values and ${y.length} y-values');

  /// x-values
  final List<double> x;

  /// y-values
  final List<double> y;

  /// The color of the graph.
  final Color? color;

  /// The Annotations which will be attached to this graph.
  final List<Annotation>? annotations;

  /// The Crosshairs which will be attached to this graph.
  final List<Crosshair>? crosshairs;


  void toLog(bool xLog, bool yLog) {
    if (xLog) {
      for (int i = 0; i < x.length; i++) {
        x[i] = x[i].toLog10();
      }
    }
    if (yLog) {
      for (int i = 0; i < x.length; i++) {
        y[i] = y[i].toLog10();
      }
    }
  }


  @override
  bool operator ==(Object other) =>
      other is Graph &&
      other.runtimeType == runtimeType &&
      listEquals(other.x, x) &&
      listEquals(other.y, y) &&
      listEquals(other.crosshairs, crosshairs) &&
      listEquals(other.annotations, annotations);

  @override
  int get hashCode => x.hashCode * y.hashCode;
  
  

}

