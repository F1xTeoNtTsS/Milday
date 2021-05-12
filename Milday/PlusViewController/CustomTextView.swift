//
//  CustomTextView.swift
//  Milday
//
//  Created by F1xTeoNtTsS on 04.05.2021.
//

import UIKit

class CustomTextView: UITextView {

    var textView = UITextView()
    
    func setupTextView() {
        textView.allowsEditingTextAttributes = true
        //textView.enablesReturnKeyAutomatically = true
        textView.font = UIFont.systemFont(ofSize: 16, weight: .light)
        
        textView.isScrollEnabled = true
        textView.keyboardAppearance = .dark
        
    }
    
    func startEditing() {
        textView.becomeFirstResponder()
    }
    
    func constraintsTextView(view: UIView, navbar: UINavigationBar) {
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: navbar.bottomAnchor, constant: 10),
            textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }

}
