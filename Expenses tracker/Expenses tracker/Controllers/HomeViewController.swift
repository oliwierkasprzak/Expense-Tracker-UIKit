//
//  HomeViewController.swift
//  Expenses tracker
//
//  Created by Oliwier Kasprzak on 06/12/2022.
//

import UIKit
import NotificationCenter

class HomeViewController: UIViewController {
    
    
   
    
    static var expense = [Expenses]()
    
    
    
    private let mainTableCellView: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    static let mainTable: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        table.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        table.backgroundColor = .white
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(HomeViewController.mainTable)
        HomeViewController.mainTable.rowHeight = 200
        HomeViewController.mainTable.delegate = self
        HomeViewController.mainTable.dataSource = self
        // mainTable.addSubview(mainTableCellView)
        let header = BackgroundHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 350))
        HomeViewController.mainTable.tableHeaderView = header
        navigationController?.navigationBar.isHidden = true
        
        if let expense = ExpensesManager.loadExpenses() {
            HomeViewController.expense = expense
        }
        
      
        
        }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        HomeViewController.mainTable.frame = view.bounds
        HomeViewController.mainTable.separatorStyle = .none
        let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        HomeViewController.mainTable.frame = HomeViewController.mainTable.frame.inset(by: margins)
        
        
        
        
        
    }
}



extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeViewController.expense.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
            cell.backgroundColor = UIColor.white
            cell.layer.borderColor = UIColor.systemGray.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.nameLabel.text = HomeViewController.expense.reversed()[indexPath.section].name
        
        if HomeViewController.expense.reversed()[indexPath.section].amount > 0 {
            cell.amountLabel.text = "+ $" + String(HomeViewController.expense.reversed()[indexPath.section].amount)
            cell.amountLabel.textColor = UIColor(rgb: 0xacce81)
        } else if HomeViewController.expense.reversed()[indexPath.section].amount < 0 {
            cell.amountLabel.text = "- $" + String(abs(HomeViewController.expense.reversed()[indexPath.section].amount))
            cell.amountLabel.textColor = UIColor(rgb: 0x8B0000)
        }
        cell.dateLabel.text = HomeViewController.expense.reversed()[indexPath.section].date
        cell.myImageView.image = HomeViewController.expense.reversed()[indexPath.section].categoryImage
        
      
        
            return cell
            
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
              
            tableView.beginUpdates()
            let indexSet = IndexSet(integer: indexPath.section)
            tableView.deleteSections(indexSet, with: .middle)
            UserDefaults.standard.removeObject(forKey: "expense_\(indexPath.section)")
            UserDefaults.standard.synchronize()
            HomeViewController.expense.remove(at: indexPath.section)
            tableView.endUpdates()
            completion(true)
        }
    
                
           deleteAction.backgroundColor = UIColor(rgb: 0xd5bdaf)
        
            
           let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        
        
           return swipeActions
        
    }
    
  
    
    
}




