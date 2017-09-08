//
//  Folder.swift
//  DataModel
//
//  Created by Brent Simmons on 7/1/17.
//  Copyright © 2017 Ranchero Software, LLC. All rights reserved.
//

import Foundation

public final class Folder {

	public let accountID: String
	public var nameForDisplay: String
	var childObjects = [AnyObject]()
	
	init(accountID: String, nameForDisplay: String) {
		
		self.accountID = accountID
		self.nameForDisplay = nameForDisplay
		
//		NotificationCenter.default.addObserver(self, selector: #selector(unreadCountDidChange(_:)), name: .UnreadCountDidChange, object: nil)
	}
	
	// MARK: Notifications
	
//	@objc dynamic public func unreadCountDidChange(_ note: Notification) {
//
//		guard let obj = note.object else {
//			return
//		}
//		let potentialChild = obj as AnyObject
//		if isChild(potentialChild) {
//			updateUnreadCount()
//		}
//	}

//	public var unreadCount = 0 {
//		didSet {
//			if unreadCount != oldValue {
//				postUnreadCountDidChangeNotification()
//			}
//		}
//	}

//	public func updateUnreadCount() {
//		
//		unreadCount = calculateUnreadCount(childObjects)
//	}
}

extension Folder: Container {
	
	public func flattenedFeeds() -> Set<Feed> {
		
		var feeds = Set<Feed>()
		for oneChild in childObjects {
			if let oneFeed = oneChild as? Feed {
				feeds.insert(oneFeed)
			}
			else if let oneContainer = oneChild as? Container {
				feeds.formUnion(oneContainer.flattenedFeeds())
			}
		}
		return feeds
	}
	
	public func isChild(_ obj: AnyObject) -> Bool {
		
		return childObjects.contains(where: { (oneObject) -> Bool in
			return oneObject === obj
		})
	}
	
	public func visitObjects(_ recurse: Bool, _ visitBlock: VisitBlock) -> Bool {
		
		for oneObject in childObjects {
			
			if let oneContainer = oneObject as? Container {
				if visitBlock(oneObject) {
					return true
				}
				if recurse && oneContainer.visitObjects(recurse, visitBlock) {
					return true
				}
			}
			else {
				if visitBlock(oneObject) {
					return true
				}
			}
		}
		return false
	}

}


