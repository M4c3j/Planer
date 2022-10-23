	//
	//  ContentView.swift
	//  Planer
	//
	//  Created by Maciej Lipiec on 2022-08-21.
	//

import SwiftUI
import Combine
struct CalendarView: View {
	
	@EnvironmentObject var calendarModel: CalendarViewModel
	@EnvironmentObject var user: TasksViewModel
	
	var userSubscriber: AnyCancellable?
	
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
							// MARK: - Stupid trick with on change and onAppear to solve problem with 2 viewmodels
								.onChange(of: user.user.tasks) { newValue in
									calendarModel.populateCalendar(user: user.user)
								}
								.onAppear{
									calendarModel.populateCalendar(user: user.user)
								}
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

