//
//  AutoTrackingHoursTableViewCell.swift
//  PickerModal
//
//  Created by David Johnson on 11/30/17.
//  Copyright © 2017 Dave J. All rights reserved.
//

import UIKit

protocol AutoTrackingHoursCellDelegate: class {
    func autoTrackingSwitchToggled(cell: AutoTrackingHoursTableViewCell, isOn: Bool)
}

class AutoTrackingHoursTableViewCell: UITableViewCell {
    
    private let autoTrackingSwitch = UISwitch(frame: .zero)
    weak var delegate: AutoTrackingHoursCellDelegate?
    var isSwitchToggleOn = false {
        didSet {
            configure()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.text = "Auto Tracking"
        
        addSubview(autoTrackingSwitch)
        autoTrackingSwitch.translatesAutoresizingMaskIntoConstraints = false
        autoTrackingSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        autoTrackingSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        autoTrackingSwitch.addTarget(self, action: #selector(autoTrackingSwitchToggled(sender:)), for: .valueChanged)
        
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
    
    func configure() {
        autoTrackingSwitch.isOn = isSwitchToggleOn
    }
    
    // MARK: - Actions
    @objc func autoTrackingSwitchToggled(sender: UISwitch) {
        delegate?.autoTrackingSwitchToggled(cell: self, isOn: sender.isOn)
    }

}
