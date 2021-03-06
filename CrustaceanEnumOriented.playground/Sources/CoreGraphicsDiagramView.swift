import UIKit
import XCPlayground

let drawingArea = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0)

/// `CoreGraphicsDiagramView` is a `UIView` that draws itself by calling a
/// user-supplied function to generate paths in a `CGContext`, then strokes
/// the context's current path, creating lines in a pleasing shade of blue.
class CoreGraphicsDiagramView : UIView {
  override func drawRect(rect: CGRect) {
    if let context = UIGraphicsGetCurrentContext() {
      CGContextSaveGState(context)
      draw(context)
      
      let lightBlue = UIColor(red: 0.222, green: 0.617, blue: 0.976, alpha: 1.0).CGColor
      CGContextSetStrokeColorWithColor(context, lightBlue)
      CGContextSetLineWidth(context, 3)
      CGContextStrokePath(context)
      CGContextRestoreGState(context)
    }
  }
  
  var draw: (CGContext)->() = { _ in () }
}

/// Shows a `UIView` in the current playground that draws itself by invoking
/// `draw` on a `CGContext`, then stroking the context's current path in a
/// pleasing light blue.
public func showCoreGraphicsDiagram(draw: (CGContext)->()) {
  let diagramView = CoreGraphicsDiagramView(frame: drawingArea)
  diagramView.draw = draw
  diagramView.setNeedsDisplay()
  XCPlaygroundPage.currentPage.liveView = diagramView
}
