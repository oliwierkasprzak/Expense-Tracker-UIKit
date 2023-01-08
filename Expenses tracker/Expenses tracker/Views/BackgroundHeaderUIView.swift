//
//  BackgroundHeaderUIView.swift
//  Expenses tracker
//
//  Created by Oliwier Kasprzak on 07/12/2022.
//

import UIKit



class BackgroundHeaderUIView: UIView {
    
    
    
    public var balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "CURRENT BALANCE"
        label.textColor = UIColor(rgb: 0x317773)
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static var incomeLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 0.0"
        label.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        label.textColor = UIColor(rgb: 0x317773)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var expensesLabel: UILabel = {
        let label = UILabel()
        label.text = "EXPENSES"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(rgb: 0x8B0000)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let revenuesLabel: UILabel = {
        let label = UILabel()
        label.text = "REVENUES"
        label.tintColor = .white
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(rgb: 0x008000)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let expensesLabelValue: UILabel = {
        let label = UILabel()
        label.text = "$ 0.0"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(rgb: 0x8B0000)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    static let incomeLabelValue: UILabel = {
        let label = UILabel()
        label.text = "$ 0.0"
        label.textColor = UIColor(rgb: 0x008000)
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(rgb: 0xfcc796)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(balanceLabel)
        addSubview(BackgroundHeaderUIView.incomeLabel)
        addSubview(revenuesLabel)
        addSubview(expensesLabel)
        addSubview(BackgroundHeaderUIView.expensesLabelValue)
        addSubview(BackgroundHeaderUIView.incomeLabelValue)
        
        addConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func addConstraints() {
        
       let balanceLabelConstaints = [
        balanceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        balanceLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -70)
       ]
       let incomeLabelConstraints = [
        BackgroundHeaderUIView.incomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        BackgroundHeaderUIView.incomeLabel.centerYAnchor.constraint(equalTo: balanceLabel.centerYAnchor, constant: 55)
       ]
       
       let revenueLabelConstraints = [
        revenuesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
        revenuesLabel.leadingAnchor.constraint(equalTo: expensesLabel.trailingAnchor, constant: 50),
        revenuesLabel.topAnchor.constraint(equalTo: BackgroundHeaderUIView.incomeLabel.bottomAnchor, constant: 50)
       ]
       
       let expensesLabelConstraints = [
        expensesLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -100),
        expensesLabel.topAnchor.constraint(equalTo: BackgroundHeaderUIView.incomeLabel.bottomAnchor, constant: 50)
       ]
       
       let incomeLabelValueConstraints = [
        BackgroundHeaderUIView.incomeLabelValue.centerXAnchor.constraint(equalTo: revenuesLabel.centerXAnchor),
        BackgroundHeaderUIView.incomeLabelValue.topAnchor.constraint(equalTo: revenuesLabel.bottomAnchor, constant: 20)
       ]
       
       let expensesLabelValueConstraints = [
        BackgroundHeaderUIView.expensesLabelValue.centerXAnchor.constraint(equalTo: expensesLabel.centerXAnchor),
        BackgroundHeaderUIView.expensesLabelValue.topAnchor.constraint(equalTo: expensesLabel.bottomAnchor, constant: 20)
        
       ]
       NSLayoutConstraint.activate(expensesLabelValueConstraints)
       NSLayoutConstraint.activate(incomeLabelValueConstraints)
       NSLayoutConstraint.activate(revenueLabelConstraints)
       NSLayoutConstraint.activate(expensesLabelConstraints)
       NSLayoutConstraint.activate(balanceLabelConstaints)
       NSLayoutConstraint.activate(incomeLabelConstraints)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds.inset(by: UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0))
        
        
    }

}

extension UILabel {

    func addImageWith(name: String, behindText: Bool) {

        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: name)
        let attachmentString = NSAttributedString(attachment: attachment)

        guard let txt = self.text else {
            return
        }

        if behindText {
            let strLabelText = NSMutableAttributedString(string: txt)
            strLabelText.append(attachmentString)
            self.attributedText = strLabelText
        } else {
            let strLabelText = NSAttributedString(string: txt)
            let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            self.attributedText = mutableAttachmentString
        }
    }

    func removeImage() {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}






