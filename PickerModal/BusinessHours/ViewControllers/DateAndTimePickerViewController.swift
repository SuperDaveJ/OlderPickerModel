//
//  PickerModalViewController.swift
//  PickerModal
//
// Created by David Johnson on 11/30/17.
//  Copyright © 2017 Dave J. All rights reserved.
//

import UIKit

protocol DateAndTimePickerDelegate: class {
    func dateAndTimePicker(_ controller: DateAndTimePickerViewController, didSelect time: Date)
    func dateAndTimePickerDidCancel(_ controller: DateAndTimePickerViewController)
}

class DateAndTimePickerViewController: UIViewController {
    
    var datePickerView = DatePickerView(frame: .zero)
    weak var delegate: DateAndTimePickerDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss(button:)))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .clear
        
        self.view.addSubview(datePickerView)
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        datePickerView.backgroundColor = .white
        NSLayoutConstraint.activate([
            datePickerView.bottomAnchor.constraint(equalTo: self.view.safeBottomAnchor, constant: -8),
            datePickerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            datePickerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8)
        ])
        
        datePickerView.okButton.addTarget(self, action: #selector(okButtonTapped(sender:)), for: .touchUpInside)
        datePickerView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped(sender:)), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    @objc private func dismiss(button: UIButton) {
        guard let parentVC = self.presentingViewController else { return }
        parentVC.dismiss(animated: true, completion: nil)
    }
    
    @objc func okButtonTapped(sender: UIButton) {
        let date = datePickerView.datePicker.date
        delegate?.dateAndTimePicker(self, didSelect: date)
    }
    
    @objc func cancelButtonTapped(sender: UIButton) {
        delegate?.dateAndTimePickerDidCancel(self)
    }

}



extension DateAndTimePickerViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension DateAndTimePickerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}
