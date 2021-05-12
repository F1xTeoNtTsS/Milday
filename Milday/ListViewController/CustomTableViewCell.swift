//
//  CustomTableViewCell.swift
//  Milday
//
//  Created by F1xTeoNtTsS on 09.05.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    var day: Day? {
        didSet {
            dayDate.text = day?.date
            dayTitle.text = day?.description
        }
    }
    
    private let dayDate: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.monospacedDigitSystemFont(ofSize: 10, weight: .light)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let dayTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        lbl.textAlignment = .left
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(dayDate)
        addSubview(dayTitle)
        
        dayTitle.translatesAutoresizingMaskIntoConstraints = false
        dayTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        dayTitle.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        dayTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        
        dayDate.translatesAutoresizingMaskIntoConstraints = false
        dayDate.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        dayDate.topAnchor.constraint(equalTo: dayTitle.bottomAnchor, constant: 5).isActive = true
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
