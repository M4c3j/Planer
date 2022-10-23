	//
	//  TasksViewModel.swift
	//  Planer
	//
	//  Created by Maciej Lipiec on 2022-08-27.
	//

import SwiftUI
import Combine

class TasksViewModel: ObservableObject {
	
	@Published var user: User = User(name: "Maciej",
																	 tasks: [],
																	 categories: [(Category(name: "Home", color: .green, SFSymbolName: .home)),
																								Category(name: "Work", color: .red, SFSymbolName: .work2)])
	{
		didSet {
			self.populateCalendar()
		}
	}
	@Published var calendarModel = CalendarModel(currentDate: Date(),
																							 daysInMonth: Date().daysInMonth(),
																							 firstWeekDay: Date().firsWeekDay(),
																							 previousMonth: Date().previousMonth(),
																							 nextMonth: Date().nextMonth(),
																							 currentMonthName: Date().monthName())
	@Published var daysToShowInCalendar: [DayModel] = []
	@Published var weekDaysNames: [String] = []
	@Published var selectedDay: Date = .now
	@Published var tasksInSelectedDay: [Task] = []
	@Published var selectedDayID: UUID = UUID()
	@Published var tasksToShow: [Task] = []
	
	
	let dateFormatter = DateFormatter()
	
	
	init() {
		guard
			user.categories.isEmpty == false,
			let hourLater = Calendar.current.date(byAdding: DateComponents(hour: 1), to: .now)
		else {
			print("Failed to get first category or hour later in TasksViewModel")
			return
		}
		self.user.tasks.append(Task(title: "Welcome", description: "We are really happy that you are using Planer", startDate: .now, endDate: hourLater, category: user.categories[0], isRepeteable: false))
		dateFormatter.dateFormat = "HH:mm"
		self.populateWeekDaysNames()
		self.populateCalendar()
	}
	
	func addTask(_ task: Task, to category: Category) {
		DispatchQueue.main.async {
			var user = self.user
			if !user.categories.contains(category) {
				print("Category not found in user.categories")
				return
			} else if user.tasks.isEmpty {
				user.tasks.append(task)
			} else if task.startDate <= user.tasks.first!.startDate {
				user.tasks.insert(task, at: 0)
			} else if task.startDate > user.tasks.last!.startDate {
				user.tasks.append(task)
			} else {
				guard
					let indexToInsert = user.tasks.firstIndex(where: { usersTask in
						usersTask.startDate > task.startDate
					}) else {
					print("Failed to find indexToInsert")
					return
				}
				user.tasks.insert(task, at: indexToInsert)
			}
			self.user = user
		}
		
	}
	
	func deleteTask(at offsets: IndexSet) {
		let array = user.tasks
		let items = Set(offsets.map {array[$0].id})
		user.tasks.removeAll {items.contains($0.id)}
	}
	
	func tasksToShow(for day: Date) -> [Task] {
		return user.tasks.filter { task in
			print(user.tasks)
			return Calendar(identifier: .gregorian).isDate(task.startDate, equalTo: day, toGranularity: .day)
		}
	}
	
	func daysLeftToFillCalendar(_ days: [DayModel]) -> Int {
		let daysLeft = 7 - (days.count % 7)
		if daysLeft == 7 {
			return 0
		}
		return daysLeft
	}
	
	func populateCalendar() {
		var myCalendar: [DayModel] = []
		let daysInPreviousMonth = calendarModel.previousMonth.daysInMonth()
		let firstWeekDayInCurrentMonth = calendarModel.currentDate.firsWeekDay()
		let daysInCurrentMonth = calendarModel.currentDate.daysInMonth()
		
		for previousMonthDay in 1..<firstWeekDayInCurrentMonth {
			myCalendar.append(DayModel(day: daysInPreviousMonth - firstWeekDayInCurrentMonth + 1 + previousMonthDay,
																 opacity: 0.3,
																 taskColors: []))
		}
		
		for currentMonthDay in 1...daysInCurrentMonth {
			let calendar = Calendar(identifier: .gregorian)
			guard
				let day = calendar.date(byAdding: .day, value: currentMonthDay, to: calendarModel.currentDate.startOfMonth())
			else {
				print("Failed to get day in populateCalendar()")
				return
			}
			let daysTasks = user.tasks.filter { task in
				calendar.isDate(task.startDate, equalTo: day, toGranularity: .day)
			}
			var colors: [Color] = []
			for task in daysTasks {
				colors.append(task.category.color)
			}
			let colorsSet: Set<Color> = Set(colors)
			myCalendar.append(DayModel(day: currentMonthDay,
																 opacity: 1,
																 taskColors: Array(colorsSet)))
		}
		
		for nexMonthDay in 0..<daysLeftToFillCalendar(myCalendar) {
			myCalendar.append(DayModel(day: nexMonthDay + 1,
																 opacity: 0.3,
																 taskColors: []))
		}
		
		tasksToShow = user.tasks.filter { task in
			Calendar(identifier: .gregorian).isDate(task.startDate, equalTo: selectedDay, toGranularity: .day)
		}
		
		self.daysToShowInCalendar = myCalendar
	}
	
	func showNextMonth() {
		let nextMonth = calendarModel.currentDate.nextMonth()
		self.calendarModel = CalendarModel(currentDate: nextMonth,
																			 daysInMonth: nextMonth.daysInMonth(),
																			 firstWeekDay: nextMonth.firsWeekDay(),
																			 previousMonth: nextMonth.previousMonth(),
																			 nextMonth: nextMonth.nextMonth(),
																			 currentMonthName: nextMonth.monthName())
		self.populateCalendar()
	}
	
	func showPreviousMonth() {
		let previousMonth = calendarModel.currentDate.previousMonth()
		self.calendarModel = CalendarModel(currentDate: previousMonth,
																			 daysInMonth: previousMonth.daysInMonth(),
																			 firstWeekDay: previousMonth.firsWeekDay(),
																			 previousMonth: previousMonth.previousMonth(),
																			 nextMonth: previousMonth.nextMonth(),
																			 currentMonthName: previousMonth.monthName())
		self.populateCalendar()
	}
	
	func populateWeekDaysNames() {
		var weekdays: [String] = []
		let formatter = DateFormatter()
		formatter.dateFormat = "EEE"
		var date = Date().setDate(year: 2024, month: 1, day: 1, hour: 12, minute: 00)
		let myCalendar = Calendar(identifier: .gregorian)
		for _ in 0..<7 {
			weekdays.append(formatter.string(from: date))
			guard
				let nextDay = myCalendar.date(byAdding: .day, value: 1, to: date)
			else { return }
			date = nextDay
		}
		self.weekDaysNames = weekdays
	}
	
}
