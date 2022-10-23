	//
	//  AddTaskView.swift
	//  Planer
	//
	//  Created by Maciej Lipiec on 2022-09-17.
	//

import SwiftUI

struct AddTaskView: View {
		
	@EnvironmentObject var user: TasksViewModel
//	@StateObject var user: TasksViewModel = TasksViewModel()
	@Environment(\.dismiss) var dismiss
	
	@State private var title: String = ""
	@State private var description: String = ""
	@State private var startDate: Date = .now
	@State private var category: Category = Category(name: "Initializing", color: .red, SFSymbolName: .work2)
	@State private var isAddingCategory: Bool = false
	@State private var sFSymbolPicker: SFSymbols.RawValue = SFSymbols.pawprint.rawValue
	@State private var categoryNamePicker = ""
	@State private var categoryColorPicker: Color = .secondary
	private let scrollToConfirm:Int = 1
//	@FocusState private var
	
	var body: some View {
		ScrollViewReader { proxy in
			VStack{
				
				Text("Add Task \(Image(systemName: "link.badge.plus"))")
					.font(.title2)
					.fontWeight(.ultraLight)
					.padding(.top, 10)
					.id(1)
				
				List {
					
					Section("New task"){
						TextField("Title \(Image(systemName: "square.and.pencil"))", text: $title)
							.textFieldStyle(.roundedBorder)
							.multilineTextAlignment(.leading)
							.padding(4)
							.cornerRadius(10)
						TextField("Description \(Image(systemName: "rectangle.and.pencil.and.ellipsis"))", text: $description)
							.textFieldStyle(.roundedBorder)
							.multilineTextAlignment(.leading)
							.padding(4)
							.cornerRadius(10)
					}
					
					Section("Date"){
						DatePicker("Time \(Image(systemName: "clock"))", selection: $startDate, displayedComponents: [.date, .hourAndMinute] )
							.onAppear{
								UIDatePicker.appearance().minuteInterval = 5
							}
							.datePickerStyle(.compact)
					}
					
						//				Section("Category"){
						//					HStack{
						//						Text("Category \(Image(systemName: "tag"))")
						//						Spacer()
						//						Menu(category.name == "Initializing" ? "Choose  \(Image(systemName: "hand.point.up.left"))" : "\(category.name) \(Image(systemName: category.SFSymbolName.rawValue))") {
						//							ForEach(user.user.categories) { category in
						//								Button {
						//									self.category = category
						//									print(category)
						//								} label: {
						//									Label("\(category.name)", systemImage: category.SFSymbolName.rawValue)
						//								}
						//								.buttonStyle(.borderless)
						//							}
						//							Button {
						//									//
						//							} label: {
						//								Label("Create new", systemImage: "plus")
						//							}
						//						}
						//					}
						//					Picker("Category \(Image(systemName: "tag"))", selection: $category) {
						//						ForEach(user.user.categories, id:\.self) {
						////							Button {
						////								self.category = category
						////								print(category)
						////							} label: {
						////								Label("\(category.name)", systemImage: category.SFSymbolName.rawValue)
						////									.foregroundColor(.blue)
						////							}
						//							Text("\($0.name) \(Image(systemName: $0.SFSymbolName.rawValue))")
						//						}
						//					}
						//					.pickerStyle(SegmentedPickerStyle())
						//					.colorMultiply(category.color)
						//				}
					
						// MARK: - Category section
					Section("Category") {
						
						ForEach(user.user.categories, id: \.self) { category in
							Button {
								self.category = category
								proxy.scrollTo(2, anchor: .top)
							} label: {
								Label("\(category.name)", systemImage: category.SFSymbolName.rawValue)
									.frame(maxWidth: .infinity)
									.padding()
									.background(category.color.opacity(self.category == category ? 0.5 : 0.1))
									.foregroundColor(.primary)
									.cornerRadius(10)
							}
							.listRowSeparator(.hidden)
							.listRowInsets(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
						}
						
						Button {
							
							withAnimation(.easeIn(duration: 0.3)) {
//								proxy.scrollTo(1)
								isAddingCategory.toggle()
							}
							if isAddingCategory {
								DispatchQueue.main.asyncAfter(deadline: .now() + 0.31 ) {
									withAnimation(.easeIn(duration: 0.3)) {
//										proxy.scrollTo(2, anchor: .top)
									}
								}
							}
							
						} label: {
							Label("Create New", systemImage: "plus")
								.frame(maxWidth: .infinity)
								.padding()
								.background(.tertiary.opacity(0.1))
								.foregroundColor(.primary)
								.cornerRadius(10)
						}
						.animation(.easeIn(duration: 0.3), value: isAddingCategory)
						.listRowSeparator(.hidden)
						.listRowInsets(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
						
					}
					
						// MARK: - ADD new category
					if isAddingCategory {
						Section("Add new category \(Image(systemName: "plus.circle"))") {
							
							TextField("Category name \(Image(systemName: "questionmark.folder.fill"))", text: $categoryNamePicker)
								.textFieldStyle(.roundedBorder)
								.padding(4)
							
							Picker("Symbol \(Image(systemName: "heart.text.square"))", selection: $sFSymbolPicker) {
								ForEach(SFSymbols.allCases, id: \.rawValue) { symbol in
									HStack{
										Image(systemName: symbol.rawValue)
										Text("\(String(describing: symbol))")
									}
								}
							}
							
							ColorPicker("Color \(Image(systemName: "wand.and.rays"))", selection: $categoryColorPicker)
							
							HStack{
								Spacer()
								Button {
									DispatchQueue.main.async {
										user.user.categories.append(Category(name: categoryNamePicker, color: categoryColorPicker, SFSymbolName: SFSymbols(rawValue: sFSymbolPicker)!))
										self.isAddingCategory.toggle()
									}
									
								} label: {
									Text("Confirm \(Image(systemName: "checkmark.circle"))")
										.fontWeight(.semibold)
								}
								Spacer()
							}
						}
					}
					
					
						// MARK: - ADD Task section
					Section("Add task") {
						HStack{
							Spacer()
							Button {
								user.addTask(Task(title: title,
																	description: description,
																	startDate: startDate,
																	endDate: startDate,
																	category: category,
																	isRepeteable: false),
														 to: category)
								dismiss()
							} label: {
								Text("Confirm \(Image(systemName: "checkmark.circle"))")
									.fontWeight(.semibold)
							}
							.id(1)
							Spacer()
						}
					}
					.id(2)
				}
				
//				Spacer()
			}
		}
	}
}

struct AddTaskView_Previews: PreviewProvider {
	static var previews: some View {
		AddTaskView()
	}
}
