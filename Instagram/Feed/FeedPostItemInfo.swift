//
//  FeedPostItemCellInfo.swift
//  Instagram
//
//  Created by Татьяна on 03.03.2023.
//

import UIKit

struct FeedPostItemInfo {
	let userImage: UIImage
	let userName: String
	let postSubtitle: String
	let postImage: UIImage
	let numberOfLikes: Int
	let comment: CommentShortInfo?
	
	struct CommentShortInfo {
		let userName: String
		let commentText: String
	}
}
