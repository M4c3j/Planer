//
//  CalendarDaySubview.swift
//  Planer
//
//  Created by Maciej Lipiec on 2022-10-23.
//

import SwiftUI

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
