//
//  Feed.swift
//  DataModel
//
//  Created by Brent Simmons on 7/1/17.
//  Copyright © 2017 Ranchero Software, LLC. All rights reserved.
//

import Foundation
import RSCore

public final class Feed: UnreadCountProvider, DisplayNameProvider, Hashable {

	public let account: Account
	public let url: String
	public let feedID: String
	public var homePageURL: String?
	public var name: String?
	public var editedName: String?
	public var articles = Set<Article>()
	public var accountInfo: [String: Any]? //If account needs to store more data
	public let hashValue: Int
	
	public var nameForDisplay: String {
		get {
			return (editedName ?? name) ?? NSLocalizedString("Untitled", comment: "Feed name")
		}
	}

	public var unreadCount = 0 {
		didSet {
			if unreadCount != oldValue {
				postUnreadCountDidChangeNotification()
			}
		}
	}
	
	public init(account: Account, url: String, feedID: String) {

		self.account = account
		self.url = url
		self.feedID = feedID
		self.hashValue = account.hashValue ^ url.hashValue ^ feedID.hashValue
	}

	public func updateUnreadCount() {
		
		unreadCount = articles.reduce(0) { (result, oneArticle) -> Int in
			if let read = oneArticle.status?.read, !read {
				return result + 1
			}
			return result
		}
	}

	public class func ==(lhs: Feed, rhs: Feed) -> Bool {

		return lhs === rhs
	}
}

