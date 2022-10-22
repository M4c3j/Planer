//
//  DayModel.swift
//  Planer
//
//  Created by Maciej Lipiec on 2022-08-27.
//

import SwiftUI

struct DayModel: Identifiable, Hashable {
	var id = UUID()
	var day: Int
	var opacity: Double
	var taskColors: [Color]
}
