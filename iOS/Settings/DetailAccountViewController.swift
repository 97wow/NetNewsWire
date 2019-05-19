//
//  DetailAccountViewController.swift
//  NetNewsWire-iOS
//
//  Created by Maurice Parker on 5/17/19.
//  Copyright © 2019 Ranchero Software. All rights reserved.
//

import UIKit
import Account

class DetailAccountViewController: UITableViewController {

	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var activeSwitch: UISwitch!
	
	weak var account: Account?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		guard let account = account else { return }
		nameTextField.text = account.name
		nameTextField.delegate = self
		activeSwitch.isOn = account.isActive
		
    }

	override func viewWillDisappear(_ animated: Bool) {
		account?.name = nameTextField.text
		account?.isActive = activeSwitch.isOn
	}
	
}

extension DetailAccountViewController: UITextFieldDelegate {
		
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		nameTextField.resignFirstResponder()
		return true
	}
	
}
