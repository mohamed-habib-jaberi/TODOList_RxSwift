//
//  AddTaskViewController.swift
//  TODOList_RxSwift
//
//  Created by mohamed  habib on 03/08/2020.
//  Copyright © 2020 mohamed  habib. All rights reserved.
//

import UIKit


class AddTaskViewController: UIViewController {

    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 
    // MARK: - Action
    
    @IBAction func save(){
        
        guard let priority =  Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex),
            let title = self.taskTitleTextField.text
        else { return  }
        
        let task = Task(title: title, priority: priority)
    }

   

}
