//
//  ExpensesManager.swift
//  Expenses tracker
//
//  Created by Oliwier Kasprzak on 30/12/2022.
//

import Foundation
import UIKit

class ExpensesManager {
    static func saveExpenses(_ expenses: [Expenses]) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(expenses) {
                defaults.set(data, forKey: "expenses")
        }
        
    }

    static func loadExpenses() -> [Expenses]? {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "expenses") {
            let decoder = JSONDecoder()
            if let expenses = try? decoder.decode([Expenses].self, from: data) {
                return expenses
            }
        }
        return nil
    }
}

class BalanceManager {
    static func saveExpenses(_ balance: Balance) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(balance) {
            defaults.set(data, forKey: "balance")
        }
    }

    static func loadExpenses() -> Balance? {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "balance") {
            let decoder = JSONDecoder()
            if let expenses = try? decoder.decode(Balance.self, from: data) {
                return expenses
            }
        }
        return nil
    }
}

