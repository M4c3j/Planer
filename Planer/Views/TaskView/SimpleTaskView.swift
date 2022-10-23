//
//  SimpleTaskView.swift
//  Planer
//
//  Created by Maciej Lipiec on 2022-10-23.
//

import SwiftUI

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
