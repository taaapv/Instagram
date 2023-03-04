//
//  FeedViewController.swift
//  Instagram
//
//  Created by Татьяна on 02.03.2023.
//

import UIKit
import SnapKit

final class FeedViewController: UIViewController {
	// MARK: - View lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		initialize()
	}
	
	// MARK: - Private properties
	private let tableView = UITableView()
	private var items: [FeedItemType] = [
		.stories([
			FeedStoriesItemCellInfo(
				image: UIImage(named: "dog") ?? UIImage(),
				userName: "user123",
				isAddButtonVisible: true,
				isNewStory: false
			),
			FeedStoriesItemCellInfo(
				image: UIImage(named: "dog") ?? UIImage(),
				userName: "user123",
				isAddButtonVisible: false,
				isNewStory: false
			),
			FeedStoriesItemCellInfo(
				image: UIImage(named: "dog") ?? UIImage(),
				userName: "user123",
				isAddButtonVisible: false,
				isNewStory: true
			),
			FeedStoriesItemCellInfo(
				image: UIImage(named: "dog") ?? UIImage(),
				userName: "user123",
				isAddButtonVisible: false,
				isNewStory: true
			),
			FeedStoriesItemCellInfo(
				image: UIImage(named: "dog") ?? UIImage(),
				userName: "user123",
				isAddButtonVisible: false,
				isNewStory: false
			),
			FeedStoriesItemCellInfo(
				image: UIImage(named: "dog") ?? UIImage(),
				userName: "user123",
				isAddButtonVisible: false,
				isNewStory: true
			),
			FeedStoriesItemCellInfo(
				image: UIImage(named: "dog") ?? UIImage(),
				userName: "user123",
				isAddButtonVisible: false,
				isNewStory: false
			),
		]),
		.post(FeedPostItemInfo(
			userImage: UIImage(named: "dog") ?? UIImage(),
			userName: "Some_dog",
			postSubtitle: "Sponsored",
			postImage: UIImage(named: "dog") ?? UIImage(),
			numberOfLikes: 120,
			comment: FeedPostItemInfo.CommentShortInfo(
				userName: "Some_dog",
				commentText: "hahaha"
			)
		)),
		.post(FeedPostItemInfo(
			userImage: UIImage(named: "dog") ?? UIImage(),
			userName: "Some_dog",
			postSubtitle: "Sponsored",
			postImage: UIImage(named: "dog") ?? UIImage(),
			numberOfLikes: 120,
			comment: FeedPostItemInfo.CommentShortInfo(
				userName: "Some_dog",
				commentText: "hahaha"
			)
		)),
		.post(FeedPostItemInfo(
			userImage: UIImage(named: "dog") ?? UIImage(),
			userName: "Some_dog",
			postSubtitle: "Sponsored",
			postImage: UIImage(named: "dog") ?? UIImage(),
			numberOfLikes: 120,
			comment: FeedPostItemInfo.CommentShortInfo(
				userName: "Some_dog",
				commentText: "hahaha"
			)
		)),
		.post(FeedPostItemInfo(
			userImage: UIImage(named: "dog") ?? UIImage(),
			userName: "Some_dog",
			postSubtitle: "Sponsored",
			postImage: UIImage(named: "dog") ?? UIImage(),
			numberOfLikes: 120,
			comment: FeedPostItemInfo.CommentShortInfo(
				userName: "Some_dog",
				commentText: "hahaha"
			)
		)),
		.post(FeedPostItemInfo(
			userImage: UIImage(named: "dog") ?? UIImage(),
			userName: "Some_dog",
			postSubtitle: "Sponsored",
			postImage: UIImage(named: "dog") ?? UIImage(),
			numberOfLikes: 120,
			comment: FeedPostItemInfo.CommentShortInfo(
				userName: "Some_dog",
				commentText: "hahaha"
			)
		))
	]
}

// MARK: - Private methods
private extension FeedViewController {
	func initialize() {
		view.backgroundColor = .white
		navigationController?.navigationBar.tintColor = .black
		navigationItem.leftBarButtonItems = makeLeftBarButtonItems()
		navigationItem.rightBarButtonItems = makeRightBarButtonItems()
		
		tableView.dataSource = self
		tableView.separatorColor = .clear
		tableView.register(
			FeedStoriesSetCell.self,
			forCellReuseIdentifier: String(describing: FeedStoriesSetCell.self)
		)
		tableView.register(
			FeedPostCell.self,
			forCellReuseIdentifier: String(describing: FeedPostCell.self)
		)
		view.addSubview(tableView)
		
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	func makeLeftBarButtonItems() -> [UIBarButtonItem] {
		let logoBarButtonItem = UIBarButtonItem(customView: LogoView())
		let dropDownButtonItem = UIBarButtonItem(
			title: nil,
			image: UIImage(systemName: "chevron.down"),
			primaryAction: nil,
			menu: makeDropDownMenu()
		)
		return [logoBarButtonItem ,dropDownButtonItem]
	}
	
	func makeRightBarButtonItems() -> [UIBarButtonItem] {
		let addBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "plus.app"),
			style: .plain,
			target: self,
			action: #selector(didTapPlusButton)
		)
		let directBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: "paperplane"),
			style: .plain,
			target: self,
			action: #selector(didTapDirectButton)
		)
		return [addBarButtonItem, directBarButtonItem]
	}
	
	@objc func didTapPlusButton() {
		print("Add")
	}
	
	@objc func didTapDirectButton() {
		print("Direct")
	}
	
	func makeDropDownMenu() -> UIMenu {
		let subsItem = UIAction(title: "Подписки", image: UIImage(systemName: "person.2")) { _ in
			print("Subscriptions")
		}
		
		let favsItem = UIAction(title: "Избранное", image: UIImage(systemName: "star")) { _ in
			print("Favorites")
		}
		
		return UIMenu(title: "", children: [subsItem, favsItem])
	}
}

extension FeedViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = items[indexPath.row]
		switch item {
		case .stories(let info):
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedStoriesSetCell.self), for: indexPath) as? FeedStoriesSetCell else { return UITableViewCell() }
			cell.configure(with: info)
			return cell
			
		case .post(let post):
			guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedPostCell.self), for: indexPath) as? FeedPostCell  else { return UITableViewCell() }
			cell.configure(with: post)
			return cell
			
		}
	}
	
	
}
