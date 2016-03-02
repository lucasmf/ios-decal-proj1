//
//  NewToDoListTaskViewController.swift
//  ToDoList
//
//  Created by Lucas de Matos Figueredo on 2/26/16.
//  Copyright © 2016 Lucas de Matos Figueredo. All rights reserved.
//

import UIKit

class NewToDoListTaskViewController: UIViewController {
    
    var labelName: String?
    
    var newToDoTask: String?
    
    @IBOutlet weak var newToDoListTask: UITextField!
    
    
    var delegate: AddToDoTaskDelegateProtocol?
    
    @IBAction func addToDoListTask() {
        delegate?.addToDoTask(newToDoListTask?.text ?? "")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
