//
//  TaskListViewController.swift
//  TODOList_RxSwift
//
//  Created by mohamed  habib on 03/08/2020.
//  Copyright © 2020 mohamed  habib. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var perioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filtredTasks = [Task]()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    //  MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
            let addCV = navC.viewControllers.first as? AddTaskViewController
        else {  fatalError("Controller not found") }
        
        addCV.taskSubjectObservable.subscribe(onNext: { [unowned self] task in
            
            let priority = Priority(rawValue: self.perioritySegmentedControl.selectedSegmentIndex - 1)
            
            
            print(task)
            
            var excistingTasks = self.tasks.value
            excistingTasks.append(task)
            self.tasks.accept(excistingTasks)
            
            self.filterTasks(by: priority)
            
            }).disposed(by: disposeBag)
     
     }
    
    // MARK: - Filter Tasks
    private func filterTasks(by priority: Priority?){
        
        if priority == nil {
            self.filtredTasks = self.tasks.value
            self.updatedTableView()
            
        }else{
            self.tasks.map { tasks in
                
                return tasks.filter { $0.priority == priority! }
                
            }.subscribe(onNext: { [weak self] tasks in
                self?.filtredTasks = tasks
                self?.updatedTableView()
                print("####### tasks #########")
                print(tasks)
                }).disposed(by: disposeBag)
        }
    }
    
    private func updatedTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
     // MARK: - Action
    @IBAction func priorityValueChanged(segmentedControl: UISegmentedControl){
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filtredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        cell.textLabel?.text = self.filtredTasks[indexPath.row].title
        return cell
    }
    
}


