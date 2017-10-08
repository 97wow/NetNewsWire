//
//  DataExtensions.swift
//  Account
//
//  Created by Brent Simmons on 10/7/17.
//  Copyright © 2017 Ranchero Software, LLC. All rights reserved.
//

import Foundation
import Data

public extension Feed {

	var account: Account? {
		get {
			return AccountManager.shared.existingAccount(with: accountID)
		}
	}
}

public extension Article {

	var account: Account? {
		get {
			return AccountManager.shared.existingAccount(with: accountID)
		}
	}
}
