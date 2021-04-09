//
//  CurvedView.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 4/8/21.
//

import UIKit

/** This is a view which has it's top left and right corners rounded.
 */
class CurvedView: UIView {

  let cornerRadius: CGFloat = 24.0

  override func layoutSubviews() {
    super.layoutSubviews()
    setMask()

  }

  // Sets a mask on the view to round it's corners
  func setMask() {

    let maskPath = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

    let shape = CAShapeLayer()
    shape.path = maskPath.cgPath
    self.layer.mask = shape
  }
}
