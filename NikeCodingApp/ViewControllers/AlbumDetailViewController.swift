//
//  AlbumDetailViewController.swift
//  NikeCodingApp
//
//  Created by Suraj Bastola on 7/2/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailViewController: UIViewController {
	var album : Album?
	var albumImage: UIImage?
	
	private let albumArtImageView : UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let albumNameLabel: UILabel = {
		let nameLabel = UILabel()
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
		nameLabel.textAlignment = .center
		nameLabel.numberOfLines = 0
		return nameLabel
	}()
	
	private let artistNameLabel : UILabel = {
		let artistLabel = UILabel()
		artistLabel.translatesAutoresizingMaskIntoConstraints = false
		artistLabel.textColor = UIColor.darkGray
		artistLabel.textAlignment = .center
		artistLabel.numberOfLines = 0
		return artistLabel
	}()
	
	private let genreLabel : UILabel = {
		let genreLabel = UILabel()
		genreLabel.translatesAutoresizingMaskIntoConstraints = false
		genreLabel.textColor = UIColor.gray
		genreLabel.textAlignment = .center
		genreLabel.numberOfLines = 0
		return genreLabel
	}()
	
	private let releaseDateLabel : UILabel = {
		let releaseDateLabel = UILabel()
		releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
		releaseDateLabel.textColor = UIColor.gray
		releaseDateLabel.textAlignment = .center
		releaseDateLabel.numberOfLines = 0
		return releaseDateLabel
	}()
	
	private let copyrightLabel : UILabel = {
		let copyrightLabel = UILabel()
		copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
		copyrightLabel.textColor = UIColor.lightGray
		copyrightLabel.textAlignment = .center
		copyrightLabel.numberOfLines = 0
		return copyrightLabel
	}()
	
	private let backButton : UIButton = {
		let backButton = UIButton()
		backButton.translatesAutoresizingMaskIntoConstraints = false
		backButton.tintColor = UIColor.white
		backButton.layer.cornerRadius = 10
		backButton.backgroundColor = UIColor.orange
		backButton.setTitle("Back", for: .normal)
		backButton.addTarget(self, action: #selector(popViewControllerAndGoBack), for: .touchUpInside)
		return backButton
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.white
		addSubviews()
		addConstraintsToSubviews()
		updateUI()
	}
	
	private func addSubviews() {
		let subviewsToAdd = [albumArtImageView, albumNameLabel, artistNameLabel, genreLabel, copyrightLabel, backButton]
		for subviewToAdd in subviewsToAdd {
			view.addSubview(subviewToAdd)
		}
	}
	
	private func addConstraintsToSubviews() {
		let backButtonConstraints = [
			backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
		]
		NSLayoutConstraint.activate(backButtonConstraints)
		
		let stackView = UIStackView(arrangedSubviews: [albumArtImageView, albumNameLabel, artistNameLabel, genreLabel, releaseDateLabel, copyrightLabel])
		stackView.alignment = .center
		stackView.axis = .vertical
		stackView.spacing = 15
		stackView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(stackView)
		
		let stackViewConstraints = [
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
			stackView.bottomAnchor.constraint(lessThanOrEqualTo: backButton.topAnchor, constant: -20)
		]
		NSLayoutConstraint.activate(stackViewConstraints)
	}
	
	private func updateUI() {
		guard let album = album else {
			return
		}
		albumNameLabel.text = album.albumName
		artistNameLabel.text = "Artist: " + album.artistName
		
		if let albumImage = albumImage {
			albumArtImageView.image = albumImage
		} else {
			albumArtImageView.isHidden = true
		}
		
		if let genre = album.genre {
			genreLabel.text = "Genre: " + genre
		} else {
			genreLabel.isHidden = true
		}
		
		if let releaseDateString = album.releaseDateString {
			var releaseDateText = "Release Date: "
			
			if let releaseDate = DateFormatters.yyyymmddFormatter.date(from: releaseDateString) {
				let formattedDate = DateFormatters.mmmddyyyyFormatter.string(from: releaseDate)
				releaseDateText += formattedDate
			} else {
				releaseDateText += releaseDateString
			}
			releaseDateLabel.text = releaseDateText
		} else {
			releaseDateLabel.isHidden = true
		}
		
		if let copyrightInfo = album.copyrightInfo {
			copyrightLabel.text = copyrightInfo
		} else {
			copyrightLabel.isHidden = true
		}
	}
	
	@objc private func popViewControllerAndGoBack() {
		navigationController?.popViewController(animated: true)
	}
}
