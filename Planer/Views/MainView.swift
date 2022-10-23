//
//  MainView.swift
//  Planer
//
//  Created by Maciej Lipiec on 2022-10-23.
//

import SwiftUI

struct MainView: View {
	
	@EnvironmentObject var user : TasksViewModel
	@EnvironmentObject var calendarModel: CalendarViewModel
	
	var body: some View {
		TabView {
			VStack(spacing: 16) {
				CalendarView()
					.environmentObject(user)
					.environmentObject(calendarModel)
				TasksView()
					.environmentObject(user)
					.frame(minHeight: 150)
				Spacer()
			}
		}
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
