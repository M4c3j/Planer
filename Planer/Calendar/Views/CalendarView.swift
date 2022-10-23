	//
	//  ContentView.swift
	//  Planer
	//
	//  Created by Maciej Lipiec on 2022-08-21.
	//

import SwiftUI

struct ContentView: View {
	
	@EnvironmentObject var user : TasksViewModel
	
	var body: some View {
		TabView {
			VStack(spacing: 16) {
				CalendarView()
					.environmentObject(user)
				TasksView()
					.environmentObject(user)
					.frame(minHeight: 150)
				Spacer()
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

struct CalendarView: View {
	
	@EnvironmentObject var calendarModel: TasksViewModel
	
	let column: [GridItem] = [
		GridItem(.flexible(), spacing: 4),
		GridItem(.flexible(), spacing: 4),
		GridItem(.flexible(), spacing: 4),
		GridItem(.flexible(), spacing: 4),
		GridItem(.flexible(), spacing: 4),
		GridItem(.flexible(), spacing: 4),
		GridItem(.flexible(), spacing: 4)
	]
	
	let column2: [GridItem] = [
		GridItem(.flexible(), spacing: 4),
		GridItem(.flexible(), spacing: 4),
		GridItem(.flexible(), spacing: 4),
		GridItem(.flexible(), spacing: 4),
	]
	
	@State var currentDate = Date()
	@State var selectedItem: UUID = UUID()
	@State var daysInMonth: Int = 30
	@State var didTapNextMonth: Bool = false
	@State var daysOpacity: Double = 1
	
	var body: some View {
		
		VStack {
			VStack {
				// MARK: - Weekday names
				LazyVGrid(columns: column, alignment: .center, spacing: 6, pinnedViews: [.sectionHeaders]) {
					Section {
						ForEach (calendarModel.weekDaysNames, id: \.self) { weekDay in
							Text(weekDay)
								.font(.system(size: 12))
								.fontWeight(.medium)
								.padding(0)
						}
					} header: {
						// MARK: - Month with buttons
						HStack {
							Button {
								withAnimation(.easeInOut(duration: 0.4)) {
									didTapNextMonth = false
									calendarModel.showPreviousMonth()
								}
							} label: {
								Image(systemName: "chevron.left.2")
									.foregroundColor(.primary)
									.font(.system(size: 20, weight: .ultraLight, design: .default))
							}
							Text("ReallyLongTextAndLonge")
								.opacity(0)
								.overlay(
									Text(calendarModel.calendarModel.currentMonthName)
										.font(.system(size: 24, weight: .regular, design: .rounded))
										.animation(.easeInOut(duration: 0.6),value: calendarModel.calendarModel.currentMonthName)
								)
								.padding(.vertical, 6)
							Button {
								didTapNextMonth = true
								calendarModel.showNextMonth()
							} label: {
								Image(systemName: "chevron.right.2")
									.foregroundColor(.primary)
									.font(.system(size: 20, weight: .ultraLight, design: .default))
							}
						}
					}
				}
				// MARK: - Days
				LazyVGrid(columns: column, alignment: .center, spacing: 0, pinnedViews: [.sectionHeaders]){
					ForEach (calendarModel.daysToShowInCalendar, id: \.self) { index in
						CalendarDaySubView(day: index.day,
															 isSelected: calendarModel.selectedDay == Calendar(identifier: .gregorian).date(byAdding: .day, value: index.day, to: calendarModel.calendarModel.currentDate.startOfMonth())! && index.opacity == 1,
															 colors: index.taskColors)
						.onTapGesture {
							if index.opacity == 1 {
								calendarModel.selectedDay = Calendar(identifier: .gregorian).date(byAdding: .day, value: index.day, to: calendarModel.calendarModel.currentDate.startOfMonth())!
								calendarModel.populateCalendar()
//								calendarModel.selectedDayID = index.id
							}
						}
						.opacity(index.opacity)
					}
				}
			}
//			.animation(.easeInOut(duration: 0.3), value: calendarModel.daysToShowInCalendar)
			.padding(.bottom, 8)
			.padding(.horizontal, 8)
			.background(
				// MARK: - YEAR
				Text(calendarModel.calendarModel.currentDate.yearName())
					.font(.system(size: 120, weight: .heavy, design: .rounded))
					.opacity(0.15), alignment: .center
			)
			.background(LinearGradient(colors: [Color.secondary, Color(uiColor: .systemBackground)],
																 startPoint: UnitPoint(x: 0.5, y: -20),
																 endPoint: UnitPoint(x: 0.5, y: 1.5)))
			.cornerRadius(20)
			.padding(.horizontal)
			.shadow(color: .primary.opacity(0.4), radius: 3)
		}
	}
}

struct CalendarDaySubView: View {
	
	let day: Int
	let isSelected: Bool
	let colors: [Color]
	var column: [GridItem] = []
	
	init(day: Int, isSelected: Bool, colors: [Color]) {
		self.day = day
		self.isSelected = isSelected
		if !colors.isEmpty {
			self.colors = colors
		} else {
			self.colors = [.clear, .clear]
		}
		self.column = {
			self.column = []
			for _ in colors {
				self.column.append(GridItem(.flexible(), spacing: 0))
			}
			return column
		}()
	}
	
	var body: some View {
		VStack(spacing: 0){
			Text("\(day)")
				.font(.system(size: 20, weight: .thin, design: .monospaced))
			LazyVGrid(columns: column, alignment: .center, spacing: 0) {
				ForEach(colors, id: \.self) { color in
					Circle()
						.frame(width: 4)
						.foregroundColor(color)
				}
			}
		}
		.frame(minWidth: 0, maxWidth: .infinity)
		.padding(8)
		.background(isSelected ? Color.secondary.opacity(0.6) : Color.clear)
		.cornerRadius(12)
	}
}
