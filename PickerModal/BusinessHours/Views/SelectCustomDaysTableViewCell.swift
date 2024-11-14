//
//  SelectCustomDaysTableViewCell.swift
//  PickerModal
//
//  Created by David Johnson on 11/30/17.
//  Copyright © 2017 Dave J. All rights reserved.
//

import UIKit

protocol SelectCustDaysDelegate: class {
    func selectCustomDays(_ controller: SelectCustomDaysTableViewCell, add dayOfTheWeek: DayOfTheWeek?)
    func selectCustomDays( _ controller: SelectCustomDaysTableViewCell, remove dayOfTheWeek: DayOfTheWeek?)
}

enum DayOfTheWeek: Int {
    case sunday = 0, monday, tuesday, wednesday, thursday, friday, saturday
}

class SelectCustomDaysTableViewCell: UITableViewCell {
    
    private var mainStackView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private var monday: ovalDayView!
    private var tuesday: ovalDayView!
    private var wednesday: ovalDayView!
    private var thursday: ovalDayView!
    private var friday: ovalDayView!
    private var saturday: ovalDayView!
    private var sunday: ovalDayView!
    
    private var daysOfTheWeek: [ovalDayView] = []
    
    weak var delegate: SelectCustDaysDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.trailingAnchor.constraint(equalTo: self.safeTrailingAnchor, constant: -16),
            mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.safeLeadingAnchor, constant: 16)
        ])
        
        sunday = createWeekView(labelText: "S", inside: mainStackView)
        let sundayButton = createButton(for: sunday)
        sundayButton.tag = DayOfTheWeek.sunday.rawValue
        
        monday = createWeekView(labelText: "M", inside: mainStackView)
        let mondayButton = createButton(for: monday)
        mondayButton.tag = DayOfTheWeek.monday.rawValue
        
        tuesday = createWeekView(labelText: "T", inside: mainStackView)
        let tuesdayButton = createButton(for: tuesday)
        tuesdayButton.tag = DayOfTheWeek.tuesday.rawValue
        
        wednesday = createWeekView(labelText: "W", inside: mainStackView)
        let wednesdayButton = createButton(for: wednesday)
        wednesdayButton.tag = DayOfTheWeek.wednesday.rawValue
        
        thursday = createWeekView(labelText: "T", inside: mainStackView)
        let thursdayButton = createButton(for: thursday)
        thursdayButton.tag = DayOfTheWeek.thursday.rawValue
        
        friday = createWeekView(labelText: "F", inside: mainStackView)
        let fridayButton = createButton(for: friday)
        fridayButton.tag = DayOfTheWeek.friday.rawValue
        
        saturday = createWeekView(labelText: "S", inside: mainStackView)
        let saturdayButton = createButton(for: saturday)
        saturdayButton.tag = DayOfTheWeek.saturday.rawValue
        
        daysOfTheWeek = [sunday, monday, tuesday, wednesday, thursday, friday, saturday]
        
    }
    
    @objc func dayOfTheWeekTapped(sender: UIButton) {
        let dayOfTheWeek = daysOfTheWeek[sender.tag]
        dayOfTheWeek.isActive = !dayOfTheWeek.isActive
        
        if dayOfTheWeek.isActive {
            delegate?.selectCustomDays(self, add: DayOfTheWeek.init(rawValue: sender.tag))
        } else {
            delegate?.selectCustomDays(self, remove: DayOfTheWeek.init(rawValue: sender.tag))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func createButton(for weekView: ovalDayView) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.addTarget(self, action: #selector(dayOfTheWeekTapped(sender:)), for: .touchUpInside)
        weekView.addSubview(button)
        return button
    }
    
    private func createWeekView(labelText: String, inside stackView: UIStackView) -> ovalDayView {
        let circularWeekView = ovalDayView(frame: .zero)
        circularWeekView.dayText = labelText
        circularWeekView.translatesAutoresizingMaskIntoConstraints = false
        circularWeekView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        circularWeekView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        stackView.addArrangedSubview(circularWeekView)
        
        return circularWeekView
    }

}
