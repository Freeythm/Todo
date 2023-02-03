//
//  HomeView.swift
//  Todo
//
//  Created by Freeythm on 2023/02/02.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = TodoViewModel()
    @State var isFirst: Bool = false
    
    var size: CGSize {
        return UIScreen.main.bounds.size
    }
    var modelCount: Int {
        return viewModel.todoViewModel.count
    }
    
    var body: some View {
       
        NavigationStack {
         
            VStack {
                
                if modelCount == 0 {
                    
                    VStack(spacing: 1) {
                        Image("pr2")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: size.width / 1.9)
                        
                        Text("No Task")
                            .font(.title.bold())
                            .foregroundColor(.white)
                            .frame(width: size.width / 2,
                                   height: size.height / 20)
                            .background(Color("Red").opacity(isFirst ? 1.0 : 0.0), in: Capsule())
                            .onAppear {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    self.isFirst = true
                                }
                            }
                    }
                    
                } else {
                     
                    List {
                        ForEach(viewModel.todoViewModel.sorted{ $0.timeStamp > $1.timeStamp }) { items in
                            
                            NavigationLink {
                                InputView(viewModel: viewModel,
                                          todoModel: items, isEdit: true,
                                          number: viewModel.IndexOf(todoModel: items))
                                
                            } label: {
                                CellView(todoModel: items)
                            }
                            
                        }
                        .onDelete(perform: viewModel.DeleteData)
                        .buttonStyle(PlainButtonStyle())
                        .onAppear {
                            self.isFirst = false
                        }
                    
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .onAppear {
                viewModel.ReadData()
                
            }
            .navigationTitle("Todo List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    NavigationLink {
                        InputView(viewModel: viewModel,
                                  todoModel: TodoModel(task: "",
                                                       timeStamp: "",
                                                       isCheck: false)
                        )
                        
                    } label: {
                        
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                        
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func CellView(todoModel: TodoModel) -> some View {
        
        HStack(spacing: 15) {
            
            Button {
                viewModel.UpData(todoModel: TodoModel(task: todoModel.task,
                                                      timeStamp: todoModel.timeStamp,
                                                      isCheck: todoModel.isCheck ? false : true),
                                 index: viewModel.IndexOf(todoModel: todoModel)
                )
                
            } label: {
                Image(systemName: todoModel.isCheck ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(todoModel.isCheck ? Color("Red") : .gray)
            }
            
            Text(todoModel.task)
                .font(.headline)
            
            Spacer()
            
            Text(todoModel.timeStamp)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
