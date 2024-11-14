//
//  DatePickerView.swift
//  PickerModal
//
// Created by David Johnson on 11/30/17.
//  Copyright © 2017 Dave J. All rights reserved.
//

import UIKit

class DatePickerView: UIView {
    
    let datePicker: UIDatePicker = {
        var datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .time
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.minuteInterval = 15
        return datePicker
    }()
    
    let stackView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    let buttonStackView: UIStackView = {
        var buttonStackView = UIStackView(frame: .zero)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .fillEqually
        return buttonStackView
    }()
    
    let okButton: UIButton = {
        var okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        okButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return okButton
    }()
    
    let cancelButton: UIButton = {
        var cancelButton = UIButton(frame: .zero)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return cancelButton
    }()
    
    let dividerLine: UIView = {
       var dividerLine = UIView(frame: .zero)
        dividerLine.layer.borderWidth = 1
        dividerLine.layer.borderColor = UIColor(red: (211/255), green: (211/255), blue: (211/255), alpha: 1.0).cgColor
        dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return dividerLine
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 8.0
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.95)
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(dividerLine)
        stackView.addArrangedSubview(buttonStackView)
        // stackView.setCustomSpacing(-8, after: datePicker)
        
        datePicker.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(okButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
