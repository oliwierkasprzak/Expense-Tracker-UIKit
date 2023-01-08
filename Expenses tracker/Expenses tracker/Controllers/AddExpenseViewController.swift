//
//  AddExpenseViewController.swift
//  Expenses tracker
//
//  Created by Oliwier Kasprzak on 06/12/2022.
//

import UIKit

class AddExpenseViewController: UIViewController {
    
    let nameField = UITextField()
    let dateField = UITextField()
    let typeField = UITextField()
    let amountField = UITextField()
    let saveButton = UIButton()
    
    var balance = Balance(income: 0, outcome: 0, balance: 0) {
        didSet {
            BackgroundHeaderUIView.incomeLabel.text = "$ \(balance.balance)"
            BackgroundHeaderUIView.incomeLabelValue.text = "$ \(balance.income)"
            BackgroundHeaderUIView.expensesLabelValue.text = "$ \(balance.outcome)"
        }
    }
    
    
    let categories = ["airplane.circle.fill", "bag.circle.fill", "dollarsign.circle.fill", "popcorn.circle.fill", "creditcard.circle.fill", "house.circle.fill"]
    let colors = [UIColor(rgb: 0x1f4766), UIColor(rgb: 0x2d5082), UIColor(rgb: 0xb59378), UIColor(rgb: 0xa27150), UIColor(rgb: 0xfcac65), UIColor(rgb: 0xbf9973)]
    var images = [UIImage]()
   
    var selectedCategory: String?
    let categoryPicker = UIPickerView()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let balances = BalanceManager.loadExpenses() {
            balance.balance = balances.balance
            balance.outcome = balances.outcome
            balance.income = balances.income
        }
    
        nameField.placeholder = "Enter the name"
        dateField.placeholder = "Enter the date"
        typeField.placeholder = "Enter the type"
        amountField.placeholder = "Enter the amount"

        nameField.borderStyle = .roundedRect
        dateField.borderStyle = .roundedRect
        typeField.borderStyle = .roundedRect
        amountField.borderStyle = .roundedRect
            
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.blue, for: .normal)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        dateField.translatesAutoresizingMaskIntoConstraints = false
        typeField.translatesAutoresizingMaskIntoConstraints = false
        amountField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
             
        view.addSubview(nameField)
        view.addSubview(dateField)
        //view.addSubview(typeField)
        view.addSubview(amountField)
        view.addSubview(saveButton)
        view.addSubview(categoryPicker)
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        view.backgroundColor = UIColor(rgb: 0xfcc796)
        
      //  categoryPicker.transform = CGAffineTransform(rotationAngle: -90 * (.pi/180))
        categoryPicker.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        
        
        for (symbol, color) in zip(categories, colors) {
            let image = UIImage(systemName: symbol)?.withTintColor(color, renderingMode: .alwaysOriginal)
            images.append(image!)
        }
        
        
        addConstraints()
        
    }
    
    func errorAlert() {
        let ac = UIAlertController(title: "Error", message: "Please provide correct data for field: amount", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(ac, animated: true)
        
    }
    
    @objc func save() {
        
        let name = nameField.text
        let date = dateField.text
        let type = typeField.text
        guard let amount = Double(amountField.text!) else {
            errorAlert()
            return
        }
        
        let selectedRow = categoryPicker.selectedRow(inComponent: 0)
        let category = images[selectedRow]
        let categoryData = category.pngData()
        
        let item = Expenses(name: name ?? "", date: date ?? "", type: type ?? "", amount: amount, category: categoryData!)
        //BackgroundHeaderUIView.balance += amount
        
        
        
        if amount > 0 {
           balance.income += amount
           balance.balance += amount
        } else if amount < 0 {
           balance.outcome += amount
           balance.balance += amount
        }
        
        HomeViewController.expense.append(item)
        HomeViewController.mainTable.reloadData()
        ExpensesManager.saveExpenses(HomeViewController.expense)
        BalanceManager.saveExpenses(balance)
        
        
       
    }
    
  func addConstraints() {
      
      let constraints = [
          nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          nameField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
          nameField.widthAnchor.constraint(equalToConstant: 350),
          nameField.heightAnchor.constraint(equalToConstant: 45),
          
          //dateField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          dateField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 35),
          dateField.widthAnchor.constraint(equalToConstant: 150),
          dateField.heightAnchor.constraint(equalToConstant: 45),
          dateField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
          amountField.leadingAnchor.constraint(equalTo: dateField.trailingAnchor, constant: 50),
          
          
          //amountField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          amountField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 35),
          
          amountField.widthAnchor.constraint(equalToConstant: 150),
          amountField.heightAnchor.constraint(equalToConstant: 45),
          
          categoryPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          categoryPicker.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 0),
         // categoryPicker.widthAnchor.constraint(equalToConstant: 200),
          //categoryPicker.heightAnchor.constraint(equalToConstant: 200),
          
          saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          saveButton.topAnchor.constraint(equalTo: categoryPicker.bottomAnchor, constant: 10),
          saveButton.widthAnchor.constraint(equalToConstant: 200),
          saveButton.heightAnchor.constraint(equalToConstant: 30),
      ]
      
      NSLayoutConstraint.activate(constraints)
        
        
        }
    }
    

extension AddExpenseViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(image: images[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        switch Color(rawValue: row) {
            case .red:
                imageView.tintColor = UIColor(rgb: 0x1f4766)
            case .orange:
                imageView.tintColor = UIColor(rgb: 0x2d5082)
            case .systemGreen:
                imageView.tintColor = UIColor(rgb: 0xb59378)
            case .systemYellow:
                imageView.tintColor = UIColor(rgb: 0xa27150)
            case .blue:
                imageView.tintColor = UIColor(rgb: 0xfcac65)
            case .purple:
                imageView.tintColor = UIColor(rgb: 0xbf9973)
            default:
                break
            }
        
        return imageView
        }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
}


enum Color: Int {
    case red
    case orange
    case systemGreen
    case systemYellow
    case blue
    case purple
}

   
    

    
    
    


