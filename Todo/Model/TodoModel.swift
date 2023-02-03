//
//  TodoModel.swift
//  Todo
//
//  Created by Freeythm on 2023/02/02.
//

import SwiftUI

struct TodoModel: Identifiable, Codable, Equatable {
    var id = UUID().uuidString
    var task: String
    var timeStamp: String
    var isCheck: Bool
}


