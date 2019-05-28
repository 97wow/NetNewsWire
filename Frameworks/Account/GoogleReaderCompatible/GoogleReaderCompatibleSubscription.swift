//
//  GoogleReaderCompatibleFeed.swift
//  Account
//
//  Created by Brent Simmons on 12/10/17.
//  Copyright © 2017 Ranchero Software, LLC. All rights reserved.
//

import Foundation
import RSCore
import RSParser

struct GoogleReaderCompatibleSubscription: Codable {

	let subscriptionID: Int
	let feedID: Int
	let name: String?
	let url: String
	let homePageURL: String?

	enum CodingKeys: String, CodingKey {
		case subscriptionID = "id"
		case feedID = "feed_id"
		case name = "title"
		case url = "feed_url"
		case homePageURL = "site_url"
	}

}

struct GoogleReaderCompatibleCreateSubscription: Codable {
	let feedURL: String
	enum CodingKeys: String, CodingKey {
		case feedURL = "feed_url"
	}
}

struct GoogleReaderCompatibleUpdateSubscription: Codable {
	let title: String
	enum CodingKeys: String, CodingKey {
		case title
	}
}

struct GoogleReaderCompatibleSubscriptionChoice: Codable {
	
	let name: String?
	let url: String
	
	enum CodingKeys: String, CodingKey {
		case name = "title"
		case url = "feed_url"
	}
	
}
