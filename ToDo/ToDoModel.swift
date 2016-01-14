//
//  ToDoModel.swift
//  ToDo
//
//  Created by xuqidong on 15/8/29.
//  Copyright (c) 2015年 xuqidong. All rights reserved.
//

import UIKit


//var todos: [ToDoModel] = []



class ToDoModel: NSObject {

    var id: String
    var image: String
    var title: String
    var date: NSDate
    
    init(id: String, image: String, title: String, date: NSDate) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}

