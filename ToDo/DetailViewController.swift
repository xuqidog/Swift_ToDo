//
//  DetailViewController.swift
//  ToDo
//
//  Created by xuqidong on 15/8/29.
//  Copyright (c) 2015年 xuqidong. All rights reserved.
//


import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var carButton: UIButton!
    @IBOutlet var musicButton: UIButton!
    @IBOutlet var peopleButton: UIButton!
    @IBOutlet var phoneButton: UIButton!
    @IBOutlet var todoItem: UITextField!
    @IBOutlet var todoDate: UIDatePicker!
    
    
    var todo: ToDoModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        todoItem.delegate = self
        
        
        if todo == nil {
            carButton.selected = true
            navigationController?.title = "新增"
        }
        else {
            navigationController?.title = "修改ToDo"
            if todo?.image == "car-hl" {
                carButton.selected = true
            }
            else if todo?.image == "music-hl" {
                musicButton.selected = true
            }
            else if todo?.image == "people-hl" {
                peopleButton.selected = true
            }
            else if todo?.image == "phone-hl" {
                phoneButton.selected = true
            }
            
            todoItem.text = todo?.title
            todoDate.setDate((todo?.date)!, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func resetButtons() {
        carButton.selected = false
        musicButton.selected = false
        peopleButton.selected = false
        phoneButton.selected = false
    }
    
    @IBAction func carTapped(sender: AnyObject) {
        resetButtons()
        carButton.selected = true
    }
    
    @IBAction func musicTapped(sender: AnyObject) {
        resetButtons()
        musicButton.selected = true
    }
    
    @IBAction func peopelTapped(sender: AnyObject) {
        resetButtons()
        peopleButton.selected = true
    }
    @IBAction func phoneTapped(sender: AnyObject) {
        resetButtons()
        phoneButton.selected = true
    }
    

    
    //OK
    @IBAction func OK(sender: AnyObject) {
        var image = ""
        if carButton.selected {
            image = "car-hl"
        }
        else if musicButton.selected {
            image = "music-hl"
        }
        else if peopleButton.selected {
            image = "people-hl"
        }
        else if phoneButton.selected {
            image = "phone-hl"
        }
        
        
        //新增
        if todo == nil {
            let uuid = NSUUID().UUIDString
            var todo = ToDoModel(id: uuid, image: image, title: todoItem.text, date: todoDate.date)
            todos.append(todo)
        }
        // 修改
        else {
            todo?.image = image
            todo?.title = todoItem.text
            todo?.date = todoDate.date
        }
    }
    
    
    // 消失键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //点击别处消失键盘
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        todoItem.resignFirstResponder()
    }
}