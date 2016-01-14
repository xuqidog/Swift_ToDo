//
//  ViewController.swift
//  ToDo
//
//  Created by xuqidong on 15/8/29.
//  Copyright (c) 2015年 xuqidong. All rights reserved.
//

import UIKit

var todos: [ToDoModel] = []
var filteredTodos:[ToDoModel] = []//存搜索的结果

var boo: Bool = false



func dateFromString(dateStr: String) -> NSDate? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.dateFromString(dateStr)
    return date
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchDisplayDelegate {

    @IBOutlet var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        todos = [ToDoModel(id: "1", image: "car-hl", title: "1.练车", date: dateFromString("2014-11-2")!),ToDoModel(id: "2", image: "music-hl", title: "2.听音乐", date: dateFromString("2015-11-2")!),ToDoModel(id: "3", image: "people-hl", title: "3.购物", date: dateFromString("2014-11-02")!),ToDoModel(id: "4", image: "phone-hl", title: "4.打电话", date: dateFromString("2014-1-2")!)]
        
    
        
        //左边编辑按钮
        navigationItem.leftBarButtonItem = editButtonItem()
        
        
        //隐藏搜索栏
        var contenOffset = tableview.contentOffset
        contenOffset.y += searchDisplayController!.searchBar.frame.size.height
        tableview.contentOffset = contenOffset
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return filteredTodos.count
        
        //搜索的cell
//        if tableview == searchDisplayController!.searchResultsTableView {
        if boo == true {
            return filteredTodos.count
        }
        else {
            return todos.count
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCellWithIdentifier("todoCell") as! UITableViewCell
        var todo: ToDoModel
        
        //搜索的cell
        
//        todo = filteredTodos[indexPath.row] as ToDoModel
//        if tableview == searchDisplayController!.searchResultsTableView {
        if boo == true {
            todo = filteredTodos[indexPath.row] as ToDoModel
        }
        else {
            todo = todos[indexPath.row] as ToDoModel
        }
        
        
        //绑定
        var image = cell.viewWithTag(1000) as! UIImageView
        var title = cell.viewWithTag(1001) as! UILabel
        var date = cell.viewWithTag(1002) as! UILabel
        
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        
        //格式化时间格式
        let locale = NSLocale.currentLocale()
        let dateFormat = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        date.text = dateFormatter.stringFromDate(todo.date)
        
    
        return cell
    }
    
    
    // UITableViewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            todos.removeAtIndex(indexPath.row)
//            self.tableview.reloadData()
            self.tableview.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    
    
    //Edit
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableview.setEditing(editing, animated: animated)
    }
    
    //Move 移动cell改变顺序
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return editing
    }
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let todo = todos.removeAtIndex(sourceIndexPath.row)
        todos.insert(todo, atIndex: destinationIndexPath.row)
    }
    
    
    
    //Search
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        
        filteredTodos = todos.filter() {
            $0.title.rangeOfString(searchString) != nil
        }
        
        if searchString.isEmpty {
            boo = false
        }
        else {
            boo = true
        }
        
        println(filteredTodos)
        return true
    }
    
    
    
    
    
    
    //返回
    @IBAction func close(segue: UIStoryboardSegue) {
        println("closed")
        tableview.reloadData()
    }
    
    
    // push
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "EditToDo" {
            var vc = segue.destinationViewController as! DetailViewController
            var indexPath = tableview.indexPathForSelectedRow()
            if let index = indexPath {
                vc.todo = todos[index.row]
            }
            
        }
    }
}

