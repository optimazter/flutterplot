import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutterplot/src/models/annotation.dart';
import 'package:flutterplot/src/rendering/annotation_render_element.dart';
import 'package:flutterplot/src/utils/utils.dart';



class AnnotationLayout extends MultiChildRenderObjectWidget {

  AnnotationLayout({
    required this.annotations,
    required this.transform,
  }) : super(children: annotations);

  final List<Annotation> annotations;
  final Matrix4 transform;


  @override
  MultiChildRenderObjectElement createElement() => AnnotationRenderElement(this);

  @override
  AnnotationRenderObject createRenderObject(BuildContext context) {
    return AnnotationRenderObject()..transform = transform;
  } 
  

  @override
  void updateRenderObject(BuildContext context, AnnotationRenderObject renderObject) {
    super.updateRenderObject(context, renderObject);
    renderObject.transform = transform;
  }

}





class AnnotationRenderObject extends RenderBox with ContainerRenderObjectMixin<RenderBox, AnnotationParentData> {


  Matrix4 transform = Matrix4.identity();
  

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! AnnotationParentData) {
      child.parentData = AnnotationParentData();
    }
  }


  @override
  void performLayout() {
    RenderBox? child = firstChild;
    while (child != null) {
      final AnnotationParentData childParentData = child.parentData! as AnnotationParentData;
      child.layout(constraints, parentUsesSize: true);
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
    size = constraints.smallest;
  }


  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    context.canvas.save();
    context.canvas.clipRect(Rect.fromLTRB(offset.dx, offset.dy, offset.dx + constraints.maxWidth, offset.dy + constraints.maxHeight));
    while (child != null) {
      final AnnotationParentData childParentData = child.parentData! as AnnotationParentData;
      final Offset globalPosition = transform.transformOffset(childParentData.position) + offset - constraints.biggest.center(Offset.zero);
      context.paintChild(child, globalPosition);
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
    context.canvas.restore();

  }








}
