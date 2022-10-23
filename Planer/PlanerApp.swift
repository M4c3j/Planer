//
//  PlanerApp.swift
//  Planer
//
//  Created by Maciej Lipiec on 2022-08-21.
//

import SwiftUI

@main
struct PlanerApp: App {
	
	@StateObject var user: TasksViewModel = TasksViewModel()
	@StateObject var calendarModel: CalendarViewModel = CalendarViewModel()
	
	var body: some Scene {
		
		WindowGroup {
			MainView()
			.environmentObject(user)
			.environmentObject(calendarModel)
		}
	}
}

