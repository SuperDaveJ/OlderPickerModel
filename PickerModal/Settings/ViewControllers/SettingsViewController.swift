//
//  SettingsViewController.swift
//  PickerModal
//
//  Created by David Johnson on 11/30/17.
//  Copyright © 2017 Dave J. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    var autoTrackingEnabled = false
    fileprivate let businessHoursCellIndex = IndexPath(row: 1, section: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor)
        ])
        
        // This will set whether the business hours cell will be enabled
        // and if the switch is toggled on/off
        autoTrackingEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AutoTrackHoursSegue" {
            let vc = segue.destination as? BusinessHoursViewController
            vc?.delegate = self
            vc?.autoTrackingType = sender as? AutoTrackingBusinessHoursType ?? .allDay
        }
    }

}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let businessHoursCell = tableView.cellForRow(at: indexPath) as? BusinessHoursTableViewCell
            let autoTrackingType = businessHoursCell?.autoTrackingType
            performSegue(withIdentifier: "AutoTrackHoursSegue", sender: autoTrackingType)
        }
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = AutoTrackingHoursTableViewCell(style: .default, reuseIdentifier: nil)
            cell.delegate = self
            cell.isSwitchToggleOn = autoTrackingEnabled
            return cell
        } else if indexPath.section == 0 && indexPath.row == 1 {
            let cell = BusinessHoursTableViewCell(style: .value1, reuseIdentifier: nil)
            cell.isEnabled = autoTrackingEnabled
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - AutoTrackingHoursCellDelegate
extension SettingsViewController: AutoTrackingHoursCellDelegate {
    func autoTrackingSwitchToggled(cell: AutoTrackingHoursTableViewCell, isOn: Bool) {
        let cell = self.tableView.cellForRow(at: businessHoursCellIndex) as? BusinessHoursTableViewCell
        cell?.isEnabled = isOn
    }
}

// MARK: - BusinessHoursViewControllerDelegate
extension SettingsViewController: BusinessHoursViewControllerDelegate {
    func businessHours(_ controller: BusinessHoursViewController, save autoTrackingType: AutoTrackingBusinessHoursType) {
        let businessHoursCell = tableView.cellForRow(at: businessHoursCellIndex) as? BusinessHoursTableViewCell
        businessHoursCell?.autoTrackingType = autoTrackingType
    }
}
