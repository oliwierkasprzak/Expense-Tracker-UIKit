//
//  ChartViewUIView.swift
//  Expenses tracker
//
//  Created by Oliwier Kasprzak on 23/12/2022.
//

import UIKit
import Charts

class ChartViewUIView: UIView {
    
       let mainView = UIView()
       
       let topView = UIView()
       
       let bottomView = UIView()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           
           topView.backgroundColor = .red
           
           mainView.translatesAutoresizingMaskIntoConstraints = false
           addSubview(mainView)
           NSLayoutConstraint.activate([
               mainView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
               mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
               mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
               mainView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
           ])
           
           
           topView.translatesAutoresizingMaskIntoConstraints = false
           mainView.addSubview(topView)
           NSLayoutConstraint.activate([
               topView.topAnchor.constraint(equalTo: mainView.topAnchor),
               topView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
               topView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
               topView.bottomAnchor.constraint(equalTo: mainView.centerYAnchor)
           ])
           
           
           bottomView.translatesAutoresizingMaskIntoConstraints = false
           mainView.addSubview(bottomView)
           NSLayoutConstraint.activate([
               bottomView.topAnchor.constraint(equalTo: mainView.centerYAnchor),
               bottomView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
               bottomView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
               bottomView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
           ])
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
}


