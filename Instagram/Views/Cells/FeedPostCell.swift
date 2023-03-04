//
//  FeedPostCell.swift
//  Instagram
//
//  Created by Татьяна on 03.03.2023.
//

import UIKit
import SnapKit

final class FeedPostCell: UITableViewCell {
	// MARK: - Private properties
	private let userImageView: UIImageView = {
		let view = UIImageView()
		view.layer.cornerRadius = UIConstants.userImageSize / 2
		view.clipsToBounds = true
		return view
	}()
	
	private let userNameLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(
			ofSize: UIConstants.userNameLabelFontSize,
			weight: .bold
		)
		return label
	}()
	
	private let subtitleLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: UIConstants.subtitleLabelFontSize)
		return label
	}()
	
	private let optionsButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
		button.tintColor = .black
		return button
	}()
	
	private let postImageView: UIImageView = {
		let view = UIImageView()
		
		return view
	}()
	
	private let likeButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "heart"), for: .normal)
		button.tintColor = .black
		return button
	}()
	
	private let commentButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
		button.tintColor = .black
		return button
	}()
	
	private let shareButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "paperplane"), for: .normal)
		button.tintColor = .black
		return button
	}()
	
	private let likesLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: UIConstants.likesLabelFontSize, weight: .bold)
		return label
	}()
	
	private let commentLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: UIConstants.commentLabelFontSize)
		return label
	}()
	
	// MARK: - Private constants
	private enum UIConstants {
		static let userImageSize: CGFloat = 30
		static let contentInset: CGFloat = 12
		static let userImageTopInset: CGFloat = 6
		static let userNameLabelFontSize: CGFloat = 14
		static let subtitleLabelFontSize: CGFloat = 11
		static let userNameSubtitleToProfileImageOffset: CGFloat = 12
		static let postImageToUserImageOffset: CGFloat = 6
		static let actionsStackToPostImageOffset: CGFloat = 6
		static let actionsStackHeight: CGFloat = 24
		static let actionsStackSpacing: CGFloat = 12
		static let likesLabelToActionsStackOffset: CGFloat = 6
		static let likesLabelFontSize: CGFloat = 14
		static let commentLabelFontSize: CGFloat = 14
		static let commentLabelToLikesLabelOffset: CGFloat = 12
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
	func configure(with post: FeedPostItemInfo) {
		userImageView.image = post.postImage
		userNameLabel.text = post.userName
		subtitleLabel.text = post.postSubtitle
		postImageView.image = post.postImage
		likesLabel.text = "Нравится: \(post.numberOfLikes)"
		
		if let comment = post.comment {
			configureCommentLabel(with: comment)
		}
		
	}
}

// MARK: - Private methods
private extension FeedPostCell {
	func initialize() {
		selectionStyle = .none
		contentView.addSubview(userImageView)
		userImageView.snp.makeConstraints { make in
			make.leading.equalToSuperview().inset(UIConstants.contentInset)
			make.top.equalToSuperview().inset(UIConstants.userImageTopInset)
			make.size.equalTo(UIConstants.userImageSize)
		}
		let userNameSubtitleStack = UIStackView()
		userNameSubtitleStack.axis = .vertical
		userNameSubtitleStack.addArrangedSubview(userNameLabel)
		userNameSubtitleStack.addArrangedSubview(subtitleLabel)
		contentView.addSubview(userNameSubtitleStack)
		userNameSubtitleStack.snp.makeConstraints { make in
			make.centerY.equalTo(userImageView)
			make.leading.equalTo(userImageView.snp.trailing).offset(UIConstants.userNameSubtitleToProfileImageOffset)
		}
		contentView.addSubview(optionsButton)
		optionsButton.snp.makeConstraints { make in
			make.centerY.equalTo(userNameSubtitleStack)
			make.trailing.equalToSuperview().inset(UIConstants.contentInset)
		}
		contentView.addSubview(postImageView)
		postImageView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalTo(userImageView.snp.bottom).offset(UIConstants.postImageToUserImageOffset)
			make.height.equalTo(contentView.snp.width)
		}
		let actionsStack = UIStackView()
		actionsStack.axis = .horizontal
		actionsStack.addArrangedSubview(likeButton)
		actionsStack.addArrangedSubview(commentButton)
		actionsStack.addArrangedSubview(shareButton)
		actionsStack.spacing = UIConstants.actionsStackSpacing
		contentView.addSubview(actionsStack)
		actionsStack.snp.makeConstraints { make in
			make.height.equalTo(UIConstants.actionsStackHeight)
			make.leading.equalToSuperview().inset(UIConstants.contentInset)
			make.top.equalTo(postImageView.snp.bottom).offset(UIConstants.actionsStackToPostImageOffset)
		}
		contentView.addSubview(likesLabel)
		likesLabel.snp.makeConstraints { make in
			make.top.equalTo(actionsStack.snp.bottom).offset(UIConstants.likesLabelToActionsStackOffset)
			make.leading.equalToSuperview().inset(UIConstants.contentInset)
		}
		contentView.addSubview(commentLabel)
		commentLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
			make.top.equalTo(likesLabel.snp.bottom).offset(UIConstants.commentLabelToLikesLabelOffset)
			make.bottom.equalToSuperview().inset(UIConstants.contentInset)
		}
	}
	
	func configureCommentLabel(with comment: FeedPostItemInfo.CommentShortInfo) {
		let string = comment.userName + " " + comment.commentText
		let attributedString = NSMutableAttributedString(string: string)
		let range = NSRange(location: .zero, length: comment.userName.count)
		attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: UIConstants.commentLabelFontSize), range: range)
		commentLabel.attributedText = attributedString
	}
}
