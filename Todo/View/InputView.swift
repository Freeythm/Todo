//
//  InputView.swift
//  Todo
//
//  Created by Freeythm on 2023/02/02.
//

import SwiftUI

struct InputView: View {
    @Environment(\.self) var env
    @ObservedObject var viewModel = TodoViewModel()
    var todoModel: TodoModel
    
    @State var isEdit: Bool = false
    @State var isSave: Bool = false
    @State var number: Int?
    
    @State var task: String = ""
    @State var isCheck: Bool = false
    @State var timeStamp: String = Date().formatted(date: .numeric, time: .shortened)
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                TitleView(title: "Task")
                Spacer()
                TextField("Task Input Here", text: $task)
                    .textFieldStyle(.roundedBorder)
            }
            
            Divider()
            
            HStack {
                TitleView(title: "Date")
                
                Spacer()
                
                if isEdit {
                    Group {
                        Text("\(todoModel.timeStamp) → ")
                            .padding(.vertical, 10)
                        Text(timeStamp)
                            .foregroundColor(Color("Red"))
                    }
                    .font(.caption)
                    
                } else {
                    Text(timeStamp)
                        .padding(.vertical, 10)
                }
            }
            
            Divider()
            
            HStack {
                TitleView(title: "Check")
                
                Spacer()
                
                Button {
                    self.isCheck.toggle()
                    
                } label: {
                    Image(systemName: isCheck ?  "checkmark.circle.fill" : "circle")
                        .font(.title3)
                        .foregroundColor(isCheck ? Color("Red") : .gray)
                        .padding(.vertical, 10)
                }
            }
            
            Divider()
            
            //MARK: Save&UpData.............
            Button(isEdit ? "UpData" : "Save", role: .destructive) {
                
                if isEdit {
                    viewModel.UpData(todoModel: TodoModel(task: task,
                                                          timeStamp: Date().formatted(date: .numeric, time: .shortened),
                                                          isCheck: isCheck),
                                     index: number!)
                    
                } else {
                    viewModel.todoViewModel.append(TodoModel(task: task,
                                                             timeStamp: timeStamp,
                                                             isCheck: false))
                }
                env.dismiss()
                
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
            
            Spacer()
        }
        .padding(.vertical, 50)
        .padding(.horizontal, 30)
        .onAppear {
            if isEdit {
                self.task = todoModel.task
                self.isCheck = todoModel.isCheck
                
            } else {
                self.task = task
                self.isCheck = isCheck
            }
        }
        .navigationTitle(isEdit ? "編集画面" : "入力画面")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: TitleView.............
    @ViewBuilder
    func TitleView(title: String) -> some View {
        Text("□ \(title)：")
            .font(.headline)
            .foregroundColor(.gray)
    }
    
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(todoModel: TodoModel(task: "", timeStamp: "", isCheck: false))
    }
}
