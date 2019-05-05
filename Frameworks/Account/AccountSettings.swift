//
//  AccountSettings.swift
//  Account
//
//  Created by Brent Simmons on 3/3/19.
//  Copyright © 2019 Ranchero Software, LLC. All rights reserved.
//

import Foundation

protocol AccountSettingsDelegate: class {
	func valueDidChange(_ accountSettings: AccountSettings, key: AccountSettings.CodingKeys)
}

final class AccountSettings: Codable {

	enum CodingKeys: String, CodingKey {
		case name
		case isActive
		case username
	}

	var name: String? {
		didSet {
			if name != oldValue {
				valueDidChange(.name)
			}
		}
	}
	
	var isActive: Bool = true {
		didSet {
			if isActive != oldValue {
				valueDidChange(.isActive)
			}
		}
	}
	
	var username: String? {
		didSet {
			if username != oldValue {
				valueDidChange(.username)
			}
		}
	}

	weak var delegate: AccountSettingsDelegate?
	
	func valueDidChange(_ key: CodingKeys) {
		delegate?.valueDidChange(self, key: key)
	}
	
}
