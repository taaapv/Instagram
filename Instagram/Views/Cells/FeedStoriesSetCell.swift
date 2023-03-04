//
//  FeedStoriesSetCell.swift
//  Instagram
//
//  Created by Татьяна on 03.03.2023.
//

import UIKit
import SnapKit

final class FeedStoriesSetCell: UITableViewCell {
	
	// MARK: - Private properties
	private var collectionView: UICollectionView!
	private var items: FeedStoriesCellInfo = []
	
	// MARK: - Private constants
	private enum UIConstants {
		static let collectionViewHeight: CGFloat = 106
		static let cellWidth: CGFloat = 72
		static let cellHeight: CGFloat = 98
	}
	
	// MARK: - Init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initialize()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public methods
	func configure(with info: FeedStoriesCellInfo) {
		self.items = info
		collectionView.reloadData()
	}
}

// MARK: - Private methods
private extension FeedStoriesSetCell {
	func initialize() {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(
			FeedStoriesItemCell.self,
			forCellWithReuseIdentifier: String(describing: FeedStoriesItemCell.self)
		)
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.showsHorizontalScrollIndicator = false
		contentView.addSubview(collectionView)
		collectionView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
			make.height.equalTo(UIConstants.collectionViewHeight)
		}
	}
}

// MARK: - UICollectionViewDataSource
extension FeedStoriesSetCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let item = items[indexPath.row]
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: String(describing: FeedStoriesItemCell.self),
			for: indexPath
		) as? FeedStoriesItemCell else { return UICollectionViewCell() }
		cell.configure(with: item)
		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedStoriesSetCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: UIConstants.cellWidth, height: UIConstants.cellHeight)
	}
}
