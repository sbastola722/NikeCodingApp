//
//  DateFormatter.swift
//  NikeCodingApp
//
//  Created by Suraj Bastola on 7/2/20.
//  Copyright © 2020 Suraj Bastola. All rights reserved.
//

import Foundation

public struct DateFormatters {
	public static var mmmddyyyyFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "MMM dd, yyyy"
		return formatter
	}()
	
	public static var yyyymmddFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-mm-dd"
		return formatter
	}()
}
