//
//  DayOfTheWeekTableViewCell.swift
//  PickerModal
//
//  Created by David Johnson on 11/30/17.
//  Copyright © 2017 Dave J. All rights reserved.
//

import UIKit

protocol DayOfTheWeekCellDelegate: class {
    func dayOfTheWeekTableViewCell(_ controller: DayOfTheWeekTableViewCell, tappedStart startTimeButton: UIButton)
    func dayOfTheWeekTableViewCell(_ controller: DayOfTheWeekTableViewCell, tappedEnd endTimeButton: UIButton)
}

class DayOfTheWeekTableViewCell: UITableViewCell {
    
    var startTimeButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.setTitle("8:00 AM", for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    var endTimeButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.setTitle("5:00 PM", for: .normal)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private var mainStackView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var buttonStackView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private var toLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = "—"
        label.textColor = UIColor(red: (144/255), green: (144/255), blue: (144/255), alpha: 1.0)
        return label
    }()
    
    var weekLabel: UILabel = {
        var weekLabel = UILabel(frame: .zero)
        weekLabel.text = "Day"
        weekLabel.sizeToFit()
        weekLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return weekLabel
    }()
    
    private let dividerLine: UIView = {
        var dividerLine = UIView(frame: .zero)
        dividerLine.layer.borderWidth = 2
        dividerLine.layer.borderColor = UIColor(red: (211/255), green: (211/255), blue: (211/255), alpha: 1.0).cgColor
        
        dividerLine.widthAnchor.constraint(equalToConstant: 2).isActive = true
        return dividerLine
    }()
    
    private let bufferView: UIView = {
        var view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return view
    }()
    
    weak var delegate: DayOfTheWeekCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.safeTopAnchor, constant: 4),
            mainStackView.trailingAnchor.constraint(equalTo: self.safeTrailingAnchor, constant: -32),
            mainStackView.bottomAnchor.constraint(equalTo: self.safeBottomAnchor, constant: -4),
            mainStackView.leadingAnchor.constraint(equalTo: self.safeLeadingAnchor, constant: 16)
        ])
        
        mainStackView.addArrangedSubview(weekLabel)
        mainStackView.addArrangedSubview(dividerLine)
        mainStackView.addArrangedSubview(bufferView)
        mainStackView.addArrangedSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(startTimeButton)
        buttonStackView.addArrangedSubview(toLabel)
        buttonStackView.addArrangedSubview(endTimeButton)
        
        startTimeButton.addTarget(self, action: #selector(startTimeButtonTapped(sender:)), for: .touchUpInside)
        endTimeButton.addTarget(self, action: #selector(endTimeButtonTapped(sender:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func startTimeButtonTapped(sender: UIButton) {
        delegate?.dayOfTheWeekTableViewCell(self, tappedStart: sender)
    }
    
    @objc func endTimeButtonTapped(sender: UIButton) {
        delegate?.dayOfTheWeekTableViewCell(self, tappedEnd: sender)
    }

}
