//
//  GuidedOnboading.swift
//  Baur
//
//  Created by Philipp Dümlein on 02.11.18.
//  Copyright © 2018 empiriecom GmbH & Co. KG. All rights reserved.
//

import UIKit

class Onboarder: UIView {
    
    var targetView: UIView?
    var baseView = UIView(frame: CGRect.zero)
    
    let baseLayer = CAShapeLayer()
    var pulsatingLayer: CAShapeLayer?
    var biggerSide: CGFloat = 0
    
    let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(targetView: UIView?, baseView: UIView) {
        super.init(frame: UIScreen.main.bounds)
        self.targetView = targetView
        self.baseView = baseView
        setupOnboarding()
    }
    
    private func setupOnboarding() {
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        setupPulsatingLayer()
        setupBaseLayer()
//        setupLabel(with: "Hey schau doch mal unser neues iOS-Feature an")
    }
    
    private func setupBaseLayer() {
        baseLayer.strokeColor = UIColor.yellow.cgColor
        baseLayer.fillColor = UIColor.clear.cgColor
        setupLayer(layer: baseLayer)
    }
    
    private func setupPulsatingLayer() {
        pulsatingLayer = CAShapeLayer()
        guard let pulsatingLayer = pulsatingLayer else { return }
        pulsatingLayer.strokeColor = UIColor.yellow.cgColor.copy(alpha: 0.2)
        pulsatingLayer.fillColor = UIColor.clear.cgColor
        setupLayer(layer: pulsatingLayer)
        animatePulsatingLayer()
    }
    
    private func setupLayer(layer: CAShapeLayer) {
        guard let targetView = targetView else { return }
        biggerSide = targetView.bounds.width > targetView.bounds.height ? targetView.bounds.width : targetView.bounds.height
        let circularPath = UIBezierPath(arcCenter: .zero, radius: biggerSide*3, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        let lineWidth = biggerSide*4 > 250 ? 250 : biggerSide*4
        layer.lineWidth = lineWidth
        layer.position = targetView.center
        baseView.layer.addSublayer(layer)
    }
    
    private func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.3
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.duration = 0.7
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        self.pulsatingLayer?.add(animation, forKey: "pulsing")
    }
    
    private func setupLabel(with text: String) {
        guard let targetView = targetView else { return }
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        let fontSize = biggerSide/2 > 20 ? 20 : biggerSide/2
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = .center
        label.numberOfLines = 3
        self.addSubview(label)
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: targetView, attribute: .bottom, multiplier: 1, constant: biggerSide))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: targetView, attribute: .leading, multiplier: 1, constant: -biggerSide*2))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: targetView, attribute: .trailing, multiplier: 1, constant: biggerSide*2))
    }
}
