//
//  BusinessHoursTableViewCell.swift
//  PickerModal
//
//  Created by David Johnson on 11/30/17.
//  Copyright © 2017 Dave J. All rights reserved.
//

import UIKit

enum AutoTrackingBusinessHoursType: String {
    case allDay = "All Day"
    case custom = "Custom"
}

class BusinessHoursTableViewCell: UITableViewCell {
    
    var isEnabled = false {
        didSet {
            configure()
        }
    }
    
    var autoTrackingType: AutoTrackingBusinessHoursType = .allDay {
        didSet {
            configure()
        }
    }
    
    private let disabledCellGray = UIColor(red: (215/255), green: (215/255), blue: (215/255), alpha: 1.0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.text = "Business Hours:"
        self.detailTextLabel?.text = autoTrackingType.rawValue
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
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
        isUserInteractionEnabled = isEnabled
        backgroundColor = isEnabled == true ? .white : disabledCellGray
        self.detailTextLabel?.text = autoTrackingType.rawValue
    }

}
