//
//  BorderLayer.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 10/01/2021.
//

import UIKit

final class BorderLayer: CALayer {
    
    private enum Constants {
        static let lineWidth: CGFloat = 1.0
        static let strokeColor: UIColor = .white
    }
    
    struct Borders: OptionSet {
        let rawValue: Int
        
        static let top = Borders(rawValue: 1 << 0)
        static let left = Borders(rawValue: 1 << 1)
        static let bottom = Borders(rawValue: 1 << 2)
        static let right = Borders(rawValue: 1 << 3)
        
        static let all: Borders = [.top, .left, .bottom, .right]
        static let topBottom: Borders = [.top, .bottom]
        static let leftRight: Borders = [.left, .right]
    }
    
    private static var instance: BorderLayer?
    private let layerDelegate: BorderLayerDelegate!
    private weak var view: UIView?
    
    private init(view: UIView, lineWidth: CGFloat, strokeColor: UIColor, borders: Borders) {
        self.layerDelegate = BorderLayerDelegate(lineWidth: lineWidth, strokeColor: strokeColor, borders: borders)
        self.view = view
        super.init()
        self.delegate = self.layerDelegate
        addBoundsObserver()
    }
    
    override init(layer: Any) {
        self.layerDelegate = (layer as? BorderLayer)?.layerDelegate
        super.init(layer: layer)
    }
    
    deinit {
        removeBoundsObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func addBoundsObserver() {
        view?.addObserver(self, forKeyPath: "bounds", options: [], context: nil)
    }
    
    private func removeBoundsObserver() {
        view?.removeObserver(self, forKeyPath: "bounds")
    }
    
    static func instantiate(view: UIView, lineWidth: CGFloat = Constants.lineWidth, strokeColor: UIColor = Constants.strokeColor, borders: Borders = .topBottom) {
        let layer = BorderLayer(view: view, lineWidth: lineWidth, strokeColor: strokeColor, borders: borders)
        view.layer.addSublayer(layer)
        layer.needsDisplayOnBoundsChange = true
        layer.bounds = view.bounds
    }
}

extension BorderLayer {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else {
            return
        }
        
        if let view = view, keyPath == "bounds" {
            bounds = view.bounds
        }
    }
}
