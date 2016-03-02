//
//  StatsViewController.swift
//  ToDoList
//
//  Created by Lucas de Matos Figueredo on 3/1/16.
//  Copyright © 2016 Lucas de Matos Figueredo. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var numberOfCompletedTasks: UILabel!
    var numberOfCompletedTasksInt: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfCompletedTasks.text = String(numberOfCompletedTasksInt)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
