//
//  AlbumTableViewCell.swift
//  NikeCodingApp
//
//  Created by Suraj Bastola on 7/1/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import Foundation
import UIKit

class AlbumTableViewCell: UITableViewCell {
	var backEndRouter: BackendRouter?

	var album : Album? {
		didSet {
			if let album = album {
				albumNameLabel.text = album.albumName
				artistNameLabel.text = album.artistName
				fetchAndSetAlbumArtImageFrom(url: album.albumArtImageURL)
			}
		}
	}
	
	private let albumNameLabel: UILabel = {
		let nameLabel = UILabel()
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
		nameLabel.textAlignment = .left
		nameLabel.numberOfLines = 0
		return nameLabel
	}()
	
	
	private let artistNameLabel : UILabel = {
		let artistLabel = UILabel()
		artistLabel.translatesAutoresizingMaskIntoConstraints = false
		artistLabel.textColor = UIColor.gray
		artistLabel.textAlignment = .left
		artistLabel.numberOfLines = 0
		return artistLabel
	}()
	
	public let albumArtImageView : UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubviews()
		addConstraintsToSubviews()
	}
	
	private func addSubviews() {
		let subviewsToAdd = [albumArtImageView, albumNameLabel, artistNameLabel]
		for subviewToAdd in subviewsToAdd {
			addSubview(subviewToAdd)
		}
	}
	
	private func addConstraintsToSubviews() {
		let albumArtImageViewConstraints = [
			albumArtImageView.heightAnchor.constraint(equalToConstant: 100),
			albumArtImageView.widthAnchor.constraint(equalTo: albumArtImageView.heightAnchor),
		]
		NSLayoutConstraint.activate(albumArtImageViewConstraints)
		
		let textStackView = UIStackView(arrangedSubviews: [albumNameLabel, artistNameLabel])
		textStackView.axis = .vertical
		textStackView.alignment = .leading
		textStackView.spacing = 15
		textStackView.translatesAutoresizingMaskIntoConstraints = false
		
		let containerStackView = UIStackView(arrangedSubviews: [albumArtImageView, textStackView])
		containerStackView.axis = .horizontal
		containerStackView.alignment = .center
		containerStackView.spacing = 20
		containerStackView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(containerStackView)
		
		let stackViewConstraints = [
			containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
		]
		NSLayoutConstraint.activate(stackViewConstraints)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Reusable
extension AlbumTableViewCell: Reusable {
	static var reusableIdentifier: String {
		return "AlbumTableViewCell"
	}
}

// MARK: - Fetch image
extension AlbumTableViewCell {
	func fetchAndSetAlbumArtImageFrom(url: URL) {
		backEndRouter?.fetchAlbumImage(from: url) { (data, error) in
			DispatchQueue.main.async {[weak self] in
				guard let weakSelf = self else { return }
				// Note: A placeholder image can be set if there is an error or a retry logic can be added if desired
				guard error == nil else {
					// Note: Retry logic can be added if desired
					return
				}
				guard let data = data, let image = UIImage(data: data) else {
					return
				}
				weakSelf.albumArtImageView.image = image
			}
		}
	}
}
