//
//  AlbumTableViewController.swift
//  NikeCodingApp
//
//  Created by Suraj Bastola on 7/1/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {
	var backEndRouter: BackendRouter?
	
	private var albums = [Album]() {
		didSet {
			tableView.reloadData()
		}
	}
	
	var activityIndicator: UIActivityIndicatorView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupAlbumTableView()
		setupRefreshControl()
		fetchAlbums()
	}
	
	private func setupAlbumTableView() {
		tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.reusableIdentifier)
		tableView.estimatedRowHeight = 200.0
		tableView.rowHeight = UITableView.automaticDimension
		tableView.separatorStyle = .singleLine
	}
	
	private func setupRefreshControl() {
		refreshControl = UIRefreshControl()
		refreshControl?.attributedTitle = NSAttributedString(string: "Getting albums")
		refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
	}
	
	@objc private func refresh() {
		refreshControl?.beginRefreshing()
		fetchAlbums()
	}
	
	private func showActivityIndicatorView() {
		let activityIndicator = UIActivityIndicatorView(frame: view.frame)
		activityIndicator.hidesWhenStopped = true
		activityIndicator.style = .large
		activityIndicator.color = .gray
		activityIndicator.center = view.center
		view.addSubview(activityIndicator)
		activityIndicator.startAnimating()
		self.activityIndicator = activityIndicator
	}
	
	private func fetchAlbums() {
		guard let url = URL(string: ServicesEndPoint.albumFetchURL.rawValue) else {
			return
		}
		showActivityIndicatorView()
		
		backEndRouter?.fetchAlbums(from: url) {(albums, error) in
			DispatchQueue.main.async {[weak self] in
				guard let weakSelf = self else { return }
				if let refreshControl = weakSelf.refreshControl, refreshControl.isRefreshing {
					refreshControl.endRefreshing()
				}
				
				if let activityIndicator = weakSelf.activityIndicator, activityIndicator.isAnimating {
					activityIndicator.stopAnimating()
				}

				if let error = error {
					// Note: Retry logic can be added if desired for an error case
					
					if let apiServiceError = error as? APIServiceError {
						AlertManager.showAlertOn(viewController: weakSelf, withTitle: apiServiceError.errorMessage, andMessage:Messages.pullDownToRefresh.rawValue)
					} else {
						AlertManager.showAlertOn(viewController: weakSelf, withTitle: Messages.genericErrorMessage.rawValue + "\n" + error.localizedDescription, andMessage:Messages.pullDownToRefresh.rawValue)
					}
					return
				}
				guard let albums = albums else {
					AlertManager.showAlertOn(viewController: weakSelf, withTitle: APIServiceError.emptyData.errorMessage, andMessage:Messages.pullDownToRefresh.rawValue)
					return
				}
				weakSelf.albums = albums
			}
		}
	}
}

// MARK: - UITableViewDataSource
extension AlbumTableViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return albums.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let albumTableViewCell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.reusableIdentifier) as? AlbumTableViewCell ?? AlbumTableViewCell(style: .default, reuseIdentifier: AlbumTableViewCell.reusableIdentifier)
		
		albumTableViewCell.backEndRouter = backEndRouter
		if indexPath.row < albums.count {
			albumTableViewCell.album = albums[indexPath.row]
		}
		return albumTableViewCell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row < albums.count {
			let albumDetailViewController = AlbumDetailViewController()
			albumDetailViewController.album = albums[indexPath.row]
			
			if let albumTableViewCell = tableView.cellForRow(at: indexPath) as? AlbumTableViewCell, let albumImage = albumTableViewCell.albumArtImageView.image {
				albumDetailViewController.albumImage = albumImage
			}
			self.navigationController?.pushViewController(albumDetailViewController, animated: true)
		}
	}
}
