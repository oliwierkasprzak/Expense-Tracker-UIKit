//
//  ChartViewController.swift
//  Expenses tracker
//
//  Created by Oliwier Kasprzak on 06/12/2022.
//

import UIKit

class ChartViewController: UIViewController {
    
   
    let expense = HomeViewController.expense
    static let mainTable: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        table.frame = CGRect(x: 8, y: 0, width: 375, height: 350)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChartViewController.mainTable.rowHeight = 90
        ChartViewController.mainTable.delegate = self
        ChartViewController.mainTable.dataSource = self
        
        let halfColorView = ChartViewUIView(frame: CGRect(x: 0, y: -45, width: 1000, height: 800))
        halfColorView.bottomView.addSubview(ChartViewController.mainTable)
        view.addSubview(halfColorView)
        
        
        
    }
    
}

extension ChartViewController: UITableViewDelegate, UITableViewDataSource {
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
            cell.amountLabel.textColor = .green
        } else if HomeViewController.expense.reversed()[indexPath.section].amount < 0 {
            cell.amountLabel.text = "- $" + String(abs(HomeViewController.expense.reversed()[indexPath.section].amount))
            cell.amountLabel.textColor = .red
        }
        cell.dateLabel.text = HomeViewController.expense.reversed()[indexPath.section].date
        cell.myImageView.image = HomeViewController.expense.reversed()[indexPath.section].categoryImage
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
