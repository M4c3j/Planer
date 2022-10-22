//
//  User.swift
//  Planer
//
//  Created by Maciej Lipiec on 2022-08-27.
//

import Foundation
import SwiftUI

struct User: Identifiable, Codable {
	
	var id = UUID().uuidString
	var name: String
	var tasks: [Task]
	var categories: [Category]
	
	init(id: String = UUID().uuidString, name: String, tasks: [Task], categories: [Category]) {
		self.id = id
		self.name = name
		self.tasks = tasks
		self.categories = categories
	}
	
}

struct Task: Identifiable, Codable, Hashable{
	
	var id = UUID().uuidString
	var title: String
	var description: String
	var startDate: Date
	var endDate: Date
	var category: Category
	var isRepeteable: Bool
	var notification: CustomNotification?
	
	init( title: String, description: String, startDate: Date, endDate: Date, category: Category, isRepeteable: Bool, notification: CustomNotification? = nil) {
		self.title = title
		self.description = description
		self.startDate = startDate
		self.endDate = endDate
		self.category = category
		self.isRepeteable = isRepeteable
		self.notification = notification
	}
	
}

struct Category: Identifiable, Codable, Hashable {
	
	var id = UUID().uuidString
	var name: String
	var color: Color
	var SFSymbolName: SFSymbols
	
	init(name: String, color: Color, SFSymbolName: SFSymbols) {
		self.name = name
		self.color = color
		self.SFSymbolName = SFSymbolName
	}
	
		//użyj klasy i zrób deinit dla wzajemnych relacji,
	
}

struct CustomNotification: Identifiable, Codable, Hashable {
	
	var id = UUID().uuidString
	var notificationTitle: String
	var notificationDescription: String
	var notificationDates: [Date]
	
	init(notificationTitle: String, notificationDescription: String, notificationDates: [Date]) {
		self.notificationTitle = notificationTitle
		self.notificationDescription = notificationDescription
		self.notificationDates = notificationDates
	}
	
}

enum SFSymbols: String, Codable, CaseIterable {
	case work = "briefcase"
	case work2 = "case"
	case laundry = "tshirt"
	case doctor = "stethoscope"
	case game = "gamecontroller"
	case coffee = "cup.and.saucer.fill"
	case package = "shippingbox.fill"
	case film = "film.circle"
	case fuel = "fuelpump"
	case theater = "theatermasks"
	case ikea = "wrench.and.screwdriver"
	case photo = "camera"
	case studies = "graduationcap"
	case pawprint = "pawprint"
	case leaf = "leaf"
	case shoppingCart = "cart"
	case video = "video"
	case home = "house"
}
