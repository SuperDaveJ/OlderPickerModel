//
//  ViewController.swift
//  PickerModal
//
// Created by David Johnson on 11/30/17.
//  Copyright © 2017 Dave J. All rights reserved.
//

import UIKit

protocol BusinessHoursViewControllerDelegate: class {
    func businessHours(_ controller: BusinessHoursViewController,save autoTrackingType: AutoTrackingBusinessHoursType)
}

class BusinessHoursViewController: UIViewController {
    
    lazy var timeFormatter: DateFormatter = {
        var timeFormmatter = DateFormatter()
        timeFormmatter.dateFormat = "h:mm a"
        return timeFormmatter
    }()
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    let allDayIndexPath = IndexPath(row: 0, section: 0)
    let customIndexPath = IndexPath(row: 1, section: 0)

    var daysOfTheWeek: [WeekDay] = []
    var selectedDaysOfTheWeek: [WeekDay] = []
    
    var pickerVC: DateAndTimePickerViewController = DateAndTimePickerViewController()
    
    let selectDaysRowHeight: CGFloat = 60.0
    
    var isAllDayTracking: Bool = true {
        didSet {
            autoTrackingType = isAllDayTracking == true ? .allDay : .custom
        }
    }
    var autoTrackingType: AutoTrackingBusinessHoursType = .allDay
    
    weak var delegate: BusinessHoursViewControllerDelegate?
    
    var selectedTimeButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Business Hours"
        
        let doneNavBarButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(saveAndDismiss(sender:)))
        navigationItem.rightBarButtonItem = doneNavBarButton
        
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
        
        pickerVC.delegate = self
        
        daysOfTheWeek = createDaysOfTheWeek()
        
        isAllDayTracking = autoTrackingType == .allDay ? true : false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func createDaysOfTheWeek() -> [WeekDay] {
        var daysOfTheWeek: [WeekDay] = []
        
        daysOfTheWeek.append(WeekDay(name: "Sunday", startDate: "8:00 AM", endDate: "5:00 PM", index: 0))
        daysOfTheWeek.append(WeekDay(name: "Monday", startDate: "8:00 AM", endDate: "5:00 PM", index: 1))
        daysOfTheWeek.append(WeekDay(name: "Tuesday", startDate: "8:00 AM", endDate: "5:00 PM", index: 2))
        daysOfTheWeek.append(WeekDay(name: "Wednesday", startDate: "8:00 AM", endDate: "5:00 PM", index: 3))
        daysOfTheWeek.append(WeekDay(name: "Thursday", startDate: "8:00 AM", endDate: "5:00 PM", index: 4))
        daysOfTheWeek.append(WeekDay(name: "Friday", startDate: "8:00 AM", endDate: "5:00 PM", index: 5))
        daysOfTheWeek.append(WeekDay(name: "Saturday", startDate: "8:00 AM", endDate: "5:00 PM", index: 6))
        
        return daysOfTheWeek
    }
    
    @objc func saveAndDismiss(sender: UIBarButtonItem) {
        delegate?.businessHours(self, save: autoTrackingType)
        navigationController?.popViewController(animated: true)
    }

}

//MARK: - UITableViewDelegate
extension BusinessHoursViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        
        if indexPath.section == 0 {
            let customHoursCell = tableView.cellForRow(at: customIndexPath)
            let allDayHoursCell = tableView.cellForRow(at: allDayIndexPath)
            
            if selectedCell == allDayHoursCell {
                if isAllDayTracking == false {
                    isAllDayTracking = true
                    tableView.beginUpdates()
                    tableView.deleteSections(IndexSet(integersIn: 1...2), with: .fade)
                    tableView.endUpdates()
                }
                
            } else if selectedCell == customHoursCell {
                if isAllDayTracking == true {
                    isAllDayTracking = false
                    tableView.beginUpdates()
                    tableView.insertSections(IndexSet(integersIn: 1...2), with: .fade)
                    tableView.endUpdates()
                }
            }
            
            allDayHoursCell?.accessoryType = isAllDayTracking == true ? .checkmark : .none
            customHoursCell?.accessoryType = isAllDayTracking == true ? .none : .checkmark
            
        }
    }
    
}

//MARK: - UITableViewDataSource
extension BusinessHoursViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.section == 1) {
            return selectDaysRowHeight
        }
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Auto Tracking Hours:"
        } else if section == 1 {
            return "Days of the Week:"
        }
        
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = isAllDayTracking == true ? 1 : 3
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return selectedDaysOfTheWeek.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.text = indexPath.row == 0 ? "All Day" : "Custom"
            if indexPath.row == 0 {
                cell.accessoryType = isAllDayTracking == true ? .checkmark : .none
            } else if indexPath.row == 1 {
                cell.accessoryType = isAllDayTracking == false ? .checkmark : .none
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = SelectCustomDaysTableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        } else if indexPath.section == 2 {
            let cell = DayOfTheWeekTableViewCell(style: .default, reuseIdentifier: nil)
            cell.weekLabel.text = selectedDaysOfTheWeek[indexPath.row].abbreviation()
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - DayOfTheWeekCellDelegate
extension BusinessHoursViewController: DayOfTheWeekCellDelegate {
    func dayOfTheWeekTableViewCell(_ controller: DayOfTheWeekTableViewCell, tappedEnd endTimeButton: UIButton) {
        selectedTimeButton = endTimeButton
        DispatchQueue.main.async { [weak self] in
            self?.present(self?.pickerVC ?? DateAndTimePickerViewController(), animated: true, completion: nil)
        }
    }
    
    func dayOfTheWeekTableViewCell(_ controller: DayOfTheWeekTableViewCell, tappedStart startTimeButton: UIButton) {
        selectedTimeButton = startTimeButton
        DispatchQueue.main.async { [weak self] in
            self?.present(self?.pickerVC ?? DateAndTimePickerViewController(), animated: true, completion: nil)
        }
    }
}

// MARK: - SelectCustDaysDelegate
extension BusinessHoursViewController: SelectCustDaysDelegate {
    func selectCustomDays(_ controller: SelectCustomDaysTableViewCell, add dayOfTheWeek: DayOfTheWeek?) {
        guard let dayOfTheWeekIndex = dayOfTheWeek?.rawValue else { return }
        let selectedDayOfTheWeek = daysOfTheWeek[dayOfTheWeekIndex]
        var rowIndex = 0
        
        
        if selectedDaysOfTheWeek.count == 0 {
            selectedDaysOfTheWeek.append(selectedDayOfTheWeek)
        } else {
            rowIndex = selectedDaysOfTheWeek.count
            for (i, value) in selectedDaysOfTheWeek.enumerated() {
                if selectedDayOfTheWeek.index < value.index {
                    selectedDaysOfTheWeek.insert(selectedDayOfTheWeek, at: i)
                    rowIndex = i
                    break
                } else if selectedDayOfTheWeek.index == value.index {
                    return
                } else if i == selectedDaysOfTheWeek.count - 1 {
                    selectedDaysOfTheWeek.insert(selectedDayOfTheWeek, at: rowIndex)
                }
            }
        }
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: rowIndex, section: 2)], with: .automatic)
        tableView.endUpdates()
    }
    
    func selectCustomDays(_ controller: SelectCustomDaysTableViewCell, remove dayOfTheWeek: DayOfTheWeek?) {
        guard let dayOfTheWeekIndex = dayOfTheWeek?.rawValue else { return }
        var rowIndex = 0
        
        for (i, value) in selectedDaysOfTheWeek.enumerated() {
            if dayOfTheWeekIndex == value.index {
                rowIndex = i
                selectedDaysOfTheWeek.remove(at: i)
                break
            }
        }
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: rowIndex, section: 2)], with: .automatic)
        tableView.endUpdates()
    }
}

// MARK: - DateAndTimePickerDelegate
extension BusinessHoursViewController: DateAndTimePickerDelegate {
    func dateAndTimePicker(_ controller: DateAndTimePickerViewController, didSelect time: Date) {
        let newTime = timeFormatter.string(from: time)
        selectedTimeButton?.setTitle(newTime, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    func dateAndTimePickerDidCancel(_ controller: DateAndTimePickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}

