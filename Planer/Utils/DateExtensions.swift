//
//  DateExtensions.swift
//  Planer
//
//  Created by Maciej Lipiec on 2022-08-27.
//

import Foundation

extension Date {
		///Returns Int with weekday nr, 1-Monday...7-Sunday
	func weekDay() -> Int {
		let weekdays: [Int] = [7,1,2,3,4,5,6]
		let myCalendar = Calendar(identifier: .gregorian)
		let weekDay = myCalendar.component(.weekday, from: self)
		return weekdays[weekDay - 1]
	}
		///Returns the Date of first day in month
	func startOfMonth() -> Date {
		return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month],
																																			 from: Calendar.current.startOfDay(for: self)))!
	}
	
		///Returns Int with first weekday in current Date month
	func firsWeekDay() -> Int {
		return self.startOfMonth().weekDay()
	}
	
		///Returns the Date of last day in month
	func endOfMonth() -> Date {
		return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1),
																 to: self.startOfMonth())!
	}
	
		///Returns the number of days in current month
	func daysInMonth() -> Int {
		let myCalendar = Calendar(identifier: .gregorian)
		let range = myCalendar.range(of: .day, in: .month, for: self)
		guard
			let range = range
		else { return 0}
		return range.count
	}
	
		///Sets the date to the given
	func setDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy/MM/dd HH:mm"
		guard
			let date = formatter.date(from: "\(year)/\(month)/\(day) \(hour):\(minute)")
		else { return Date() }
		return date
	}
	
	func previousMonth() -> Date {
		let myCalendar = Calendar(identifier: .gregorian)
		guard
			let previousMonth = myCalendar.date(byAdding: .month, value: -1, to: self)
		else { return Date() }
		return previousMonth
	}
	
	func nextMonth() -> Date {
		let myCalendar = Calendar(identifier: .gregorian)
		guard
			let nextMonth = myCalendar.date(byAdding: .month, value: 1, to: self)
		else { return Date() }
		return nextMonth
	}
	
	func monthName() -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MMMM"
		return formatter.string(from: self)
	}
	
	func monthNum() -> Int {
		let formatter = DateFormatter()
		formatter.dateFormat = "M"
		guard
			let monthNum = Int(formatter.string(from: self))
		else { return 0}
		return monthNum
	}
	
	func yearName() -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy"
		return formatter.string(from: self)
	}
	
}
