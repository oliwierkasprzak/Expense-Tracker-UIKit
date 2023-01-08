//
//  CustomTableViewCell.swift
//  Expenses tracker
//
//  Created by Oliwier Kasprzak on 18/12/2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    public let myImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0xE2D1F9)
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    public let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    public let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0xE2D1F9)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(rgb: 0x317773)
        contentView.addSubview(myImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.frame.size.height-6
        
        myImageView.frame = CGRect(x: 20, y: 10, width: 70, height: 70)
        nameLabel.frame = CGRect(x: 32 + myImageView.frame.size.width, y: 0, width: contentView.frame.size.width - 10 - myImageView.frame.size.width - imageSize, height: contentView.frame.size.height - 30)
        amountLabel.frame = CGRect(x: contentView.frame.size.width - 110, y: 25, width: 100, height: 40)
        dateLabel.frame = CGRect(x: 32 + myImageView.frame.size.width, y: 50, width: 150, height: 30)
    }
    
    
}


extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
