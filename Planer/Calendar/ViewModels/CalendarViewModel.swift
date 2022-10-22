////
////  CalendarViewModel.swift
////  Planer
////
////  Created by Maciej Lipiec on 2022-08-27.
////
//
//import SwiftUI
//
//class CalendarViewModel: ObservableObject {
//
//	@Published var calendarModel = CalendarModel(currentDate: Date(),
//																							 daysInMonth: Date().daysInMonth(),
//																							 firstWeekDay: Date().firsWeekDay(),
//																							 previousMonth: Date().previousMonth(),
//																							 nextMonth: Date().nextMonth(),
//																							 currentMonthName: Date().monthName())
//	@Published var daysToShowInCalendar: [DayModel] = []
//	@Published var weekDaysNames: [String] = []
//	@Published var selectedDayID: UUID = UUID()
//
//	init() {
//		self.populateWeekDaysNames()
//		self.populateCalendar()
//	}
//
//	func daysLeftToFillCalendar(_ days: [DayModel]) -> Int {
//		let daysLeft = 7 - (days.count % 7)
//		if daysLeft == 7 {
//			return 0
//		}
//		return daysLeft
//	}
//
//	func populateCalendar() {
//		var myCalendar: [DayModel] = []
//		let daysInPreviousMonth = calendarModel.previousMonth.daysInMonth()
//		let firstWeekDayInCurrentMonth = calendarModel.currentDate.firsWeekDay()
//		let daysInCurrentMonth = calendarModel.currentDate.daysInMonth()
//
//		for previousMonthDay in 1..<firstWeekDayInCurrentMonth {
//			myCalendar.append(DayModel(day: daysInPreviousMonth - firstWeekDayInCurrentMonth + 1 + previousMonthDay,
//																 opacity: 0.3,
//																 taskColors: [Color(uiColor: .random), Color(uiColor: .random), Color(uiColor: .random), Color(uiColor: .random)]))
//		}
//
//		for currentMonthDay in 1...daysInCurrentMonth {
//			myCalendar.append(DayModel(day: currentMonthDay,
//																 opacity: 1,
//																 taskColors: [Color(uiColor: .random), Color(uiColor: .random), Color(uiColor: .random), Color(uiColor: .random)]))
//		}
//
//		for nexMonthDay in 0..<daysLeftToFillCalendar(myCalendar) {
//			myCalendar.append(DayModel(day: nexMonthDay + 1,
//																 opacity: 0.3,
//																 taskColors: [Color(uiColor: .random), Color(uiColor: .random), Color(uiColor: .random), Color(uiColor: .random)]))
//		}
//
//		self.daysToShowInCalendar = myCalendar
//	}
//
//	func showNextMonth() {
//		let nextMonth = calendarModel.currentDate.nextMonth()
//		self.calendarModel = CalendarModel(currentDate: nextMonth,
//																			 daysInMonth: nextMonth.daysInMonth(),
//																			 firstWeekDay: nextMonth.firsWeekDay(),
//																			 previousMonth: nextMonth.previousMonth(),
//																			 nextMonth: nextMonth.nextMonth(),
//																			 currentMonthName: nextMonth.monthName())
//		self.populateCalendar()
//	}
//	
//	func showPreviousMonth() {
//		let previousMonth = calendarModel.currentDate.previousMonth()
//		self.calendarModel = CalendarModel(currentDate: previousMonth,
//																			 daysInMonth: previousMonth.daysInMonth(),
//																			 firstWeekDay: previousMonth.firsWeekDay(),
//																			 previousMonth: previousMonth.previousMonth(),
//																			 nextMonth: previousMonth.nextMonth(),
//																			 currentMonthName: previousMonth.monthName())
//		self.populateCalendar()
//	}
//
//	func populateWeekDaysNames() {
//		var weekdays: [String] = []
//		let formatter = DateFormatter()
//		formatter.dateFormat = "EEE"
//		var date = Date().setDate(year: 2024, month: 1, day: 1, hour: 12, minute: 00)
//		let myCalendar = Calendar(identifier: .gregorian)
//		for _ in 0..<7 {
//			weekdays.append(formatter.string(from: date))
//			guard
//				let nextDay = myCalendar.date(byAdding: .day, value: 1, to: date)
//			else { return }
//			date = nextDay
//		}
//		self.weekDaysNames = weekdays
//	}
//
//}
