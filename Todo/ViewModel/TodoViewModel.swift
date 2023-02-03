//
//  TodoViewModel.swift
//  Todo
//
//  Created by Freeythm on 2023/02/02.
//

import SwiftUI

class TodoViewModel: ObservableObject {
    
    @Published var todoViewModel: [TodoModel] = [] {
        didSet {
            SaveData()
        }
    }
    
    //MARK: Read......
    func ReadData() {
        if let data = UserDefaults.standard.data(forKey: "TODOLIST") {
            let read = try? JSONDecoder().decode([TodoModel].self, from: data)
            self.todoViewModel = read!
    }
    
    //MARK: Save.....
    func SaveData() {
        guard let data = try? JSONEncoder().encode(todoViewModel) else {
            return
        }
        UserDefaults.standard.setValue(data, forKey: "TODOLIST")
    }
    
    //MARK: UpData.....
    func UpData(todoModel: TodoModel, index: Int) {
        self.todoViewModel[index] = todoModel
        SaveData()
    }
    
    //MARK: Delete.....
    func DeleteData(at offsets: IndexSet) {
        todoViewModel.remove(atOffsets: offsets)
        SaveData()
    }
    
    //MARK: Index......
    func IndexOf(todoModel: TodoModel) -> Int {
        return todoViewModel.firstIndex { todo in
            todo == todoModel
        } ?? 0
    }
    
}


