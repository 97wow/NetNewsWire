//
//  GoogleReaderCompatibleArticle.swift
//  Account
//
//  Created by Brent Simmons on 12/11/17.
//  Copyright © 2017 Ranchero Software, LLC. All rights reserved.
//

import Foundation
import RSParser
import RSCore

struct GoogleReaderCompatibleEntryWrapper: Codable {
	let id: String
	let updated: Int
	let entries: [GoogleReaderCompatibleEntry]
	
	
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case updated = "updated"
		case entries = "items"
	}
}

/* {
"id": "tag:google.com,2005:reader/item/00058a3b5197197b",
"crawlTimeMsec": "1559362260113",
"timestampUsec": "1559362260113787",
"published": 1554845280,
"title": "",
"summary": {
"content": "\n<p>Found an old screenshot of NetNewsWire 1.0 for iPhone!</p>\n\n<p><img src=\"https://nnw.ranchero.com/uploads/2019/c07c0574b1.jpg\" alt=\"Netnewswire 1.0 for iPhone screenshot showing the list of feeds.\" title=\"NewsGator got renamed to Sitrion, years later, and then renamed again as Limeade.\" border=\"0\" width=\"260\" height=\"320\"></p>\n"
},
"alternate": [
{
"href": "https://nnw.ranchero.com/2019/04/09/found-an-old.html"
}
],
"categories": [
"user/-/state/com.google/reading-list",
"user/-/label/Uncategorized"
],
"origin": {
"streamId": "feed/130",
"title": "NetNewsWire"
}
}
*/
struct GoogleReaderCompatibleEntry: Codable {

	let articleID: String
	let title: String?

	let publishedTimestamp: Double?
	let crawledTimestamp: String?
	let timestampUsec: String?
	
	let summary: GoogleReaderCompatibleArticleSummary
	let alternates: [GoogleReaderCompatibleAlternateLocation]
	let categories: [String]
	let origin: GoogleReaderCompatibleEntryOrigin

	enum CodingKeys: String, CodingKey {
		case articleID = "id"
		case title = "title"
		case summary = "summary"
		case alternates = "alternate"
		case categories = "categories"
		case publishedTimestamp = "published"
		case crawledTimestamp = "crawlTimeMsec"
		case origin = "origin"
		case timestampUsec = "timestampUsec"
	}
	
	func parseDatePublished() -> Date? {
		
		guard let unixTime = publishedTimestamp else {
			return nil
		}
		
		return Date(timeIntervalSince1970: unixTime)
	}
}

struct GoogleReaderCompatibleArticleSummary: Codable {
	let content: String?
	
	enum CodingKeys: String, CodingKey {
		case content = "content"
	}
}

struct GoogleReaderCompatibleAlternateLocation: Codable {
	let url: String?
	
	enum CodingKeys: String, CodingKey {
		case url = "href"
	}
}


struct GoogleReaderCompatibleEntryOrigin: Codable {
	let streamId: String?
	let title: String?

	enum CodingKeys: String, CodingKey {
		case streamId = "streamId"
		case title = "title"
	}
}

