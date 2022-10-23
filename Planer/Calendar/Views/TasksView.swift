//
//  TasksView.swift
//  Planer
//
//  Created by Maciej Lipiec on 2022-08-27.
//

import SwiftUI

struct TasksView: View {

	@EnvironmentObject var user: TasksViewModel
	
//	@ObservedObject var user: TasksViewModel = TasksViewModel()
	@State private var isAddingTask = false
	@State private var stateUser: TasksViewModel = TasksViewModel()
	
	let colors: [Color] = [.blue, .red, .yellow, .green, .pink, .orange, .brown, .cyan, .indigo, .mint, .purple, .teal]
	
	var body: some View {
		List {
			// MARK: - ADD BUTTON
			Button {
				isAddingTask.toggle()
			} label: {
				HStack {
					Text("Add task")
					Spacer()
					Image(systemName: "plus.circle")
				}
				.font(.system(size: 30, weight: .medium, design: .rounded))
				.padding(.horizontal)
				.padding(8)
				.padding(.vertical, 10)
				.background(.tertiary)
				.cornerRadius(10)
			}
			.listRowSeparator(.hidden)
			.listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 4, trailing: 0))
			.listRowBackground(Color.clear)
		
			// MARK: - TASKS
		
			ForEach(user.tasksToShow, id: \.self) { task in
				SimpleTaskView(color: task.category.color, title: task.title, description: task.description, startDate: user.dateFormatter.string(from: task.startDate), endDate: "", sfSymbol: task.category.SFSymbolName.rawValue)
					.listRowSeparator(.hidden)
					.listSectionSeparator(.hidden)
					.listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
					.listRowBackground(Color.clear)
			}
			.onDelete(perform: user.deleteTask)
		}
		.scrollContentBackground(.hidden)
		.listStyle(.plain)
		.padding(.bottom, 8)
		.padding(.horizontal, 8)
		.background(LinearGradient(colors: [Color.secondary, Color(uiColor: .systemBackground)],
															 startPoint: UnitPoint(x: 0.5, y: -20),
															 endPoint: UnitPoint(x: 0.5, y: 1.5)))
		.cornerRadius(20)
		.padding(.horizontal)
		.shadow(color: .primary.opacity(0.4), radius: 3)
		
		// MARK: - Present AddTaskView
		.sheet(isPresented: $isAddingTask) {
			AddTaskView()
				.environmentObject(user)
		}
	}
}

extension View {
	func sync(_ published: Binding<Bool>, with binding: Binding<Bool> ) -> some View {
		self
			.onChange(of: published.wrappedValue) { published in
				binding.wrappedValue = published
			}
			.onChange(of: binding.wrappedValue) { binding in
				published.wrappedValue = binding
			}
	}
}

struct SimpleTaskView: View {
	
	let color: Color
	let title: String
	let description: String
	let startDate: String
	let endDate: String
	let sfSymbol: String

	init(color: Color, title: String, description: String, startDate: String, endDate: String, sfSymbol: String) {
		self.color = color
		self.title = title
		self.description = description
		self.startDate = startDate
		self.endDate = endDate
		self.sfSymbol = sfSymbol
	}
	
	var body: some View {
		HStack {
			VStack{
				Text(startDate)
					.font(.system(size: 12))
			}
			.padding(8)
			
			VStack {
				HStack{
					Text(title)
						.font(.system(size: 16))
					Spacer()
				}
				HStack{
					Text(description)
						.font(.system(size: 12))
					Spacer()
				}
			}
			Spacer()
			Image(systemName: sfSymbol)
				.font(.system(size: 26,
											weight: .regular,
											design: .rounded))
				.padding()
		}
		.foregroundColor(color)
		.frame(maxWidth: .infinity, maxHeight: 60)
		.background(color.opacity(0.05))
		.cornerRadius(15)
	}
	
}

struct SimpleTaskView_Preview: PreviewProvider {
	static var previews: some View {
		TasksView()
			.previewLayout(.sizeThatFits)
	}
}
