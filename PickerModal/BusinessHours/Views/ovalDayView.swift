//
//  CircularWeekView.swift
//  PickerModal
//
//  Created by David Johnson on 11/30/17.
//  Copyright © 2017 Dave J. All rights reserved.
//

import UIKit

class ovalDayView: UIView {
    
    private let dayNameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = "S"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let dayOvalShapeLayer = CAShapeLayer()
    
    var isActive: Bool = false {
        didSet {
            configure()
        }
    }
    var paycomGreen = UIColor(red: 0, green: (131/255), blue: (63/255), alpha: 1.0).cgColor
    var lightGray = UIColor(red: (180/255), green: (180/255), blue: (180/255), alpha: 1.0)
    
    var dayText: String = "S" {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        layer.addSublayer(dayOvalShapeLayer)
        addSubview(dayNameLabel)
        
        NSLayoutConstraint.activate([
            dayNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dayNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShapeLayer(dayOvalShapeLayer)
    }

    func configure() {
        self.dayNameLabel.text = dayText
        self.dayNameLabel.textColor = isActive == true ? UIColor.white : lightGray
        self.layoutSubviews()
    }
    
    private func setupShapeLayer(_ shapeLayer: CAShapeLayer) {
        shapeLayer.frame = self.bounds
        shapeLayer.lineWidth = 2.0
        shapeLayer.fillColor = isActive == true ? paycomGreen : UIColor.clear.cgColor
        shapeLayer.strokeColor = isActive == true ? UIColor.clear.cgColor : lightGray.cgColor
        
        let arcCenter = shapeLayer.position
        let radius = shapeLayer.bounds.size.width / 2.0
        let startAngle = CGFloat(0.0)
        let endAngle = CGFloat(2.0 * .pi)
        let clockwise = true
        
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        shapeLayer.path = circlePath.cgPath
    }
}
