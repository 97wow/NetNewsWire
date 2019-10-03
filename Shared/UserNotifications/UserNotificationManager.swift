//
//  NotificationManager.swift
//  NetNewsWire
//
//  Created by Maurice Parker on 10/2/19.
//  Copyright © 2019 Ranchero Software. All rights reserved.
//

import Foundation
import Account
import Articles
import UserNotifications

final class UserNotificationManager: NSObject {
	
	override init() {
		super.init()
		NotificationCenter.default.addObserver(self, selector: #selector(accountDidDownloadArticles(_:)), name: .AccountDidDownloadArticles, object: nil)
	}
	
	@objc func accountDidDownloadArticles(_ note: Notification) {
		guard let articles = note.userInfo?[Account.UserInfoKey.newArticles] as? Set<Article> else {
			return
		}
		
		for article in articles {
			if let feed = article.feed, feed.isNotifyAboutNewArticles ?? false {
				sendNotification(feed: feed, article: article)
			}
		}
	}

}

private extension UserNotificationManager {
	
	private func sendNotification(feed: Feed, article: Article) {
		let content = UNMutableNotificationContent()
						
		content.title = feed.nameForDisplay
		content.body = TimelineStringFormatter.truncatedTitle(article)
		if content.body.isEmpty {
			content.body = TimelineStringFormatter.truncatedSummary(article)
		}

		content.sound = UNNotificationSound.default
		content.userInfo = article.deepLinkUserInfo

		let request = UNNotificationRequest.init(identifier: "articleID:\(article.articleID)", content: content, trigger: nil)
		UNUserNotificationCenter.current().add(request)
	}
	
}
