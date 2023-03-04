//
//  FeedStoriesItemCellInfo.swift
//  Instagram
//
//  Created by Татьяна on 03.03.2023.
//

import UIKit

struct FeedStoriesItemCellInfo {
	let image: UIImage
	let userName: String
	let isAddButtonVisible: Bool
	let isNewStory: Bool
}

typealias FeedStoriesCellInfo = [FeedStoriesItemCellInfo]
