//
//  BorderLayerDelegate.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 10/01/2021.
//

import UIKit

class BorderLayerDelegate: NSObject, CALayerDelegate {
    
    var lineWidth: CGFloat
    var strokeColor: UIColor
    var borders: BorderLayer.Borders
    
    init(lineWidth: CGFloat, strokeColor: UIColor, borders: BorderLayer.Borders) {
        self.lineWidth = lineWidth
        self.strokeColor = strokeColor
        self.borders = borders
    }
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        ctx.clear(layer.bounds)
        
        layer.anchorPoint = .zero
        ctx.setLineWidth(lineWidth)
        ctx.setStrokeColor(strokeColor.cgColor)
        
        if borders.contains(.top) {
            ctx.move(to: CGPoint(x: .zero, y: lineWidth / 2))
            ctx.addLine(to: CGPoint(x: layer.bounds.maxX, y: lineWidth / 2))
        }
        
        if borders.contains(.bottom) {
            ctx.move(to: CGPoint(x: .zero, y: layer.bounds.maxY - lineWidth / 2))
            ctx.addLine(to: CGPoint(x: layer.bounds.maxX, y: layer.bounds.maxY - lineWidth / 2))
        }
        
        if borders.contains(.left) {
            ctx.move(to: CGPoint(x: lineWidth / 2, y: .zero))
            ctx.addLine(to: CGPoint(x: lineWidth / 2, y: layer.bounds.maxY))
        }
        
        if borders.contains(.right) {
            ctx.move(to: CGPoint(x: layer.bounds.maxX - lineWidth / 2, y: .zero))
            ctx.addLine(to: CGPoint(x: layer.bounds.maxX - lineWidth, y: layer.bounds.maxY))
        }
        
        ctx.strokePath()
    }
}
