//
//  CameraView+Grid.swift of MijickCamera
//
//  Created by Tomasz Kurylik. Sending ❤️ from Kraków!
//    - Mail: tomasz.kurylik@mijick.com
//    - GitHub: https://github.com/FulcrumOne
//    - Medium: https://medium.com/@mijick
//
//  Copyright ©2024 Mijick. All rights reserved.


import SwiftUI

class CameraGridView: UIView {
    weak var parent: CameraManager?
}

// MARK: Setup
extension CameraGridView {
    func setup(parent: CameraManager) {
        self.parent = parent
        self.tag = .gridViewTag

        // Ensure there's only one grid overlay attached to the current camera view.
        parent.cameraView.subviews
            .compactMap {
                $0 as? CameraGridView
            }
            .filter {
                $0 !== self
            }
            .forEach {
                $0.removeFromSuperview()
            }

        self.alpha = parent.attributes.isGridVisible ? 1 : 0
        self.isHidden = !parent.attributes.isGridVisible
        self.addToParent(parent.cameraView)
    }
}

// MARK: Set Visibility
extension CameraGridView {
    func setVisibility(_ isVisible: Bool) {
        layer.removeAllAnimations()
        if isVisible {
            self.isHidden = false
            UIView.animate(withDuration: 0.2) { self.alpha = 1 }
        } else {
            UIView.animate(withDuration: 0.2, animations: { self.alpha = 0 }) { _ in
                self.isHidden = true
            }
        }
    }
}

// MARK: Draw
extension CameraGridView {
    override func draw(_ rect: CGRect) {
        clearOldLayersBeforeDraw()

        let firstColumnPath = UIBezierPath()
        firstColumnPath.move(to: CGPoint(x: bounds.width / 3, y: 0))
        firstColumnPath.addLine(to: CGPoint(x: bounds.width / 3, y: bounds.height))
        let firstColumnLayer = createGridLayer()
        firstColumnLayer.path = firstColumnPath.cgPath
        layer.addSublayer(firstColumnLayer)

        let secondColumnPath = UIBezierPath()
        secondColumnPath.move(to: CGPoint(x: (2 * bounds.width) / 3, y: 0))
        secondColumnPath.addLine(to: CGPoint(x: (2 * bounds.width) / 3, y: bounds.height))
        let secondColumnLayer = createGridLayer()
        secondColumnLayer.path = secondColumnPath.cgPath
        layer.addSublayer(secondColumnLayer)

        let firstRowPath = UIBezierPath()
        firstRowPath.move(to: CGPoint(x: 0, y: bounds.height / 3))
        firstRowPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height / 3))
        let firstRowLayer = createGridLayer()
        firstRowLayer.path = firstRowPath.cgPath
        layer.addSublayer(firstRowLayer)

        let secondRowPath = UIBezierPath()
        secondRowPath.move(to: CGPoint(x: 0, y: ( 2 * bounds.height) / 3))
        secondRowPath.addLine(to: CGPoint(x: bounds.width, y: ( 2 * bounds.height) / 3))
        let secondRowLayer = createGridLayer()
        secondRowLayer.path = secondRowPath.cgPath
        layer.addSublayer(secondRowLayer)
    }
}
private extension CameraGridView {
    func clearOldLayersBeforeDraw() {
        layer.sublayers?.removeAll()
        layer.backgroundColor = .none
    }
    func createGridLayer() -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(white: 1.0, alpha: 0.2).cgColor
        shapeLayer.frame = bounds
        shapeLayer.fillColor = nil
        return shapeLayer
    }
}
