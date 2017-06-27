//
//  RSSParserTests.swift
//  RSParser
//
//  Created by Brent Simmons on 6/26/17.
//  Copyright © 2017 Ranchero Software, LLC. All rights reserved.
//

import XCTest
import RSParser

class RSSParserTests: XCTestCase {

	func testScriptingNewsPerformance() {

		// 0.004 sec on my 2012 iMac.
		let d = parserData("scriptingNews", "rss", "http://scripting.com/")
		self.measure {
			let _ = try! FeedParser.parse(d)
		}
	}
}
