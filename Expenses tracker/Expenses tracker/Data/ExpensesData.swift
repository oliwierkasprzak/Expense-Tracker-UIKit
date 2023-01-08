//
//  ExpensesData.swift
//  Expenses tracker
//
//  Created by Oliwier Kasprzak on 14/12/2022.
//

import Foundation
import UIKit


struct Expenses: Codable {
    
    var name: String
    var date: String
    var type: String
    var amount: Double
    var category: Data
   
    
    
    var categoryImage: UIImage? {
           get {
               return UIImage(data: category)
           }
           set {
               if let newValue = newValue {
                   category = newValue.pngData()!
               }
           }
       }
    
}

struct Balance: Codable {
    var income: Double
    var outcome: Double
    var balance: Double
}





