//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by Lucas de Matos Figueredo on 2/26/16.
//  Copyright © 2016 Lucas de Matos Figueredo. All rights reserved.
//

import UIKit

protocol AddToDoTaskDelegateProtocol {
    func addToDoTask(taskName: String) -> Void
}

class ToDoListTableViewController: UITableViewController, AddToDoTaskDelegateProtocol {
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    var tasks = ["1"]
    var tasksClasses = [Task]() {
        didSet {
            prefs.setObject(NSKeyedArchiver.archivedDataWithRootObject(tasksClasses), forKey: "tasksClasses")
        }
    }
    
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(editingStyle == UITableViewCellEditingStyle.Delete) {
            //tasks.removeAtIndex(indexPath.row)
            tasksClasses.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    func deleteDoneTasksAfter24Hours() {
        for var index = 0; index < tasksClasses.count; index++ {
            if tasksClasses[index].shouldDelete() {
                tasksClasses.removeAtIndex(index)
            }
        }
        tableView.reloadData()
    }
    
    func getNumberOfDoneTasks() -> Int {
        var ret = 0
        for var index = 0; index < tasksClasses.count; index++ {
            if tasksClasses[index].isDone {
                ret++
            }
        }
        return ret
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        tasksClasses[indexPath.row].toggleTask()
        
        if(cell?.accessoryType != .Checkmark) {
            cell?.accessoryType = .Checkmark
        } else {
            cell?.accessoryType = .None
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        deleteDoneTasksAfter24Hours()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = prefs.objectForKey("tasksClasses") as? NSData {
            if let savedTasks = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Task]{
                tasksClasses = savedTasks
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return tasks.count
        return tasksClasses.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PrototypeCell", forIndexPath: indexPath)
        
        //cell.textLabel?.text = tasks[indexPath.row]
        cell.textLabel?.text = tasksClasses[indexPath.row].name
        if(tasksClasses[indexPath.row].isDone) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    
    func addToDoTask(taskName: String) -> Void {
        let newLine = NSIndexPath(forRow: tasksClasses.count, inSection: 0)
        
        //tasks.append(taskName)
        tasksClasses.append(Task(newName: taskName))
        
        tableView.insertRowsAtIndexPaths([newLine], withRowAnimation: .Automatic)
        print(taskName)
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier {
            switch id {
            case "NewToDoItemSegue":
                if let dvc = segue.destinationViewController as? NewToDoListTaskViewController {
                    dvc.delegate = self
                }
            case "StatsSegue":
                deleteDoneTasksAfter24Hours()
                if let dvc = segue.destinationViewController as? StatsViewController {
                    //dvc.numberOfCompletedTasksInt = tasks.count
                    dvc.numberOfCompletedTasksInt = getNumberOfDoneTasks()
                }
           
            default:
                break
            }
        }
    
    }
    
    @IBAction func addNewTaskIfPossible(sender: UIStoryboardSegue) {
        print("oi")
    }
 
  
    
    
}
