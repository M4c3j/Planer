//
//  CalendarModel.swift
//  Planer
//
//  Created by Maciej Lipiec on 2022-08-27.
//

import Foundation

struct CalendarModel {
	
	var currentDate: Date
	var daysInMonth: Int
	var firstWeekDay: Int
	var previousMonth: Date
	var nextMonth: Date
	var currentMonthName: String
	
	init(currentDate: Date,
			 daysInMonth: Int,
			 firstWeekDay: Int,
			 previousMonth: Date,
			 nextMonth: Date,
			 currentMonthName: String) {
		self.currentDate = currentDate
		self.daysInMonth = daysInMonth
		self.firstWeekDay = firstWeekDay
		self.previousMonth = previousMonth
		self.nextMonth = nextMonth
		self.currentMonthName = currentMonthName
	}
}
