//
//  ViewController.swift
//  Pulsing
//
//  Created by Philipp Dümlein on 02.11.18.
//  Copyright © 2018 Philipp Dümlein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var targetView: UIView?
    
    let baseLayer = CAShapeLayer()
    var pulsatingLayer: CAShapeLayer?
    var biggerSide: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        targetView = UIView(frame: CGRect.zero)
        guard let targetView = targetView else { return }
        targetView.backgroundColor = .white
        targetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(targetView)
        targetView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        targetView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        targetView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        targetView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        let onboarder = Onboarder(targetView: targetView, baseView: view)
        onboarder.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarder)
    }
    
    private func setupOnboarding() {
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        setupPulsatingLayer()
        setupBaseLayer()
        setupLabel(with: "Hey schau doch mal unser neues iOS-Feature an")
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
        view.layer.addSublayer(layer)
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
        view.addSubview(label)
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: targetView, attribute: .bottom, multiplier: 1, constant: biggerSide))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: targetView, attribute: .leading, multiplier: 1, constant: -biggerSide*2))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: targetView, attribute: .trailing, multiplier: 1, constant: biggerSide*2))
    }


}

