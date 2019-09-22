//
//  ChangeRateViewController.swift
//  TestChangeRate
//
//  Created by Shidong Lin on 9/21/19.
//  Copyright © 2019 Shidong Lin. All rights reserved.
//

import Foundation
import UIKit

class ChangeRateViewController: UIViewController {
    private let controller: ChangeRateControllerProtocol = ChangeRateController.shared
    private let currencyPicker = UIPickerView()
    private let pickCurrenciesButton = UIButton(type: .system)
    private let getChangeRateButton = UIButton(type: .system)
    private let changeRateLabel = UILabel()
    private let currencyPickerHeight: CGFloat = 300.0

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Currencies"

        view.backgroundColor = .white
        view.addSubview(pickCurrenciesButton)
        view.addSubview(getChangeRateButton)
        view.addSubview(changeRateLabel)
        view.addSubview(currencyPicker)

        pickCurrenciesButton.addTarget(self, action: #selector(didTapPick), for: .touchUpInside)
        pickCurrenciesButton.setTitle("Pick Currencies", for: .normal)
        pickCurrenciesButton.translatesAutoresizingMaskIntoConstraints = false
        pickCurrenciesButton.isEnabled = false

        getChangeRateButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        getChangeRateButton.setTitle("Submit", for: .normal)
        getChangeRateButton.translatesAutoresizingMaskIntoConstraints = false
        getChangeRateButton.isEnabled = false

        changeRateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pickCurrenciesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            pickCurrenciesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getChangeRateButton.topAnchor.constraint(equalTo: pickCurrenciesButton.bottomAnchor, constant: 10.0),
            getChangeRateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeRateLabel.topAnchor.constraint(equalTo: getChangeRateButton.bottomAnchor, constant: 10.0),
            changeRateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        currencyPicker.backgroundColor = .lightGray
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        currencyPicker.frame = CGRect(x: 0.0, y: view.frame.height, width: view.frame.width, height: currencyPickerHeight)

        controller.fetchCurrencies { [weak self] in
            DispatchQueue.main.async {
                self?.pickCurrenciesButton.isEnabled = true
                self?.getChangeRateButton.isEnabled = true
                self?.changeRateLabel.text = "Ready"
                self?.currencyPicker.reloadAllComponents()
            }
        }
    }

    @objc private func didTapPick() {
        UIView.animate(withDuration: 1.0) {
            self.currencyPicker.frame = CGRect(x: 0.0, y: self.view.frame.height - self.currencyPickerHeight, width: self.currencyPicker.frame.width, height: self.currencyPicker.frame.height)
        }
    }

    @objc private func didTapSubmit() {
        UIView.animate(withDuration: 1.0) {
            self.currencyPicker.frame = CGRect(x: 0.0, y: self.view.frame.height, width: self.currencyPicker.frame.width, height: self.currencyPicker.frame.height)
        }
    }
}

extension ChangeRateViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return controller.currencies.count
    }
}

extension ChangeRateViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return controller.currencies[row].id
    }
}
