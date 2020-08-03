//
//  Task.swift
//  TODOList_RxSwift
//
//  Created by mohamed  habib on 03/08/2020.
//  Copyright © 2020 mohamed  habib. All rights reserved.
//

import Foundation

enum Priority: Int {
    case high
    case meduim
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
