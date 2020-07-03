//
//  AlertManager.swift
//  NikeCodingApp
//
//  Created by Suraj Bastola on 7/2/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import Foundation
import UIKit

struct AlertManager {
	static func showAlertOn(viewController: UIViewController, withTitle title: String, andMessage message: String) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		alertController.addAction(alertAction)
		viewController.present(alertController, animated: true, completion: nil)
	}
}
