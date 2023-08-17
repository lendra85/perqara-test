//
//  GameCell.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 17/08/23.
//

import UIKit

class GameCell: UITableViewCell {
    internal lazy var gameImageView = UIImageView().with(parent: contentView)
    private lazy var titleLabel = UILabel().with(parent: contentView)
    private lazy var releaseLabel = UILabel().with(parent: contentView)
    private lazy var ratingLabel = UILabel().with(parent: contentView)
    var onImageDownloaded: ((UIImage?) -> ())?
    var game: Game? {
        didSet {
            bindDataToView()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {
        selectionStyle = .none
        setupImageView()
        setupTitleView()
        setupReleaseView()
        setupRatingView()
    }
    
    private func setupImageView() {
        gameImageView.contentMode = .scaleAspectFill
        gameImageView.cornerRadius = 5
        gameImageView.setWidth(150, andHeight: 120)
        gameImageView.makeConstraint {
            $0.topAnchor == contentView.topAnchor
            $0.bottomAnchor == contentView.bottomAnchor - .x16
            $0.leadingAnchor == contentView.leadingAnchor + .x16
        }
    }
    
    private func setupTitleView() {
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        titleLabel.makeConstraint {
            $0.topAnchor == contentView.topAnchor + .x2
            $0.leadingAnchor == gameImageView.trailingAnchor + .x8
            $0.trailingAnchor == contentView.trailingAnchor - .x16
        }
    }
    
    private func setupReleaseView() {
        releaseLabel.font = .systemFont(ofSize: 12)
        releaseLabel.textColor = .lightGray
        releaseLabel.makeConstraint {
            $0.topAnchor == titleLabel.bottomAnchor + .x4
            $0.leadingAnchor == titleLabel.leadingAnchor
            $0.trailingAnchor == titleLabel.trailingAnchor
        }
    }
    
    private func setupRatingView() {
        let ratingImage = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        let ratingImageView = UIImageView(image: ratingImage).with(parent: contentView)
        ratingImageView.tintColor = .systemYellow
        ratingImageView.makeConstraint {
            $0.leadingAnchor == releaseLabel.leadingAnchor
            $0.topAnchor == releaseLabel.bottomAnchor + .x4
        }
        ratingLabel.textColor = .lightGray
        ratingLabel.font = .systemFont(ofSize: 11)
        ratingLabel.makeConstraint {
            $0.leadingAnchor == ratingImageView.trailingAnchor + .x4
            $0.centerYAnchor == ratingImageView.centerYAnchor
        }
    }
    
    private func bindDataToView() {
        gameImageView.load(game?.backgroundImage) 
        titleLabel.text = game?.name
        releaseLabel.text = "Release Date \((game?.released).ifNil(""))"
        ratingLabel.text = "\((game?.rating).ifNil(0))"
    }
}
