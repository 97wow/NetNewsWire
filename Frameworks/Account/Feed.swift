//
//  Feed.swift
//  Account
//
//  Created by Maurice Parker on 11/15/19.
//  Copyright © 2019 Ranchero Software, LLC. All rights reserved.
//

import Foundation
import RSCore

public enum ReadFilter {
	case read
	case all
	case none
}

public protocol Feed: FeedIdentifiable, ArticleFetcher, DisplayNameProvider, UnreadCountProvider {

	var defaultReadFilter: ReadFilter { get }
	
}
