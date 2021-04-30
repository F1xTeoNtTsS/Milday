//
//  PlusViewController.swift
//  Milday
//
//  Created by Dmitrii Abanin on 4/27/21.
//

import UIKit

class PlusViewController: UIViewController {

    let navbar = UINavigationBar()
    let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isModalInPresentation = true
        view.backgroundColor = .white
        
        setupNavigationBar()
        addSubViews()
        constraintsTF()
    }
    
    func setupNavigationBar() {
        
        navbar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        navbar.backgroundColor = .none

        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closePlusVC))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)

        navbar.items = [navItem]
    }
    
    func setupTextView() {
        textView.allowsEditingTextAttributes = true
        textView.enablesReturnKeyAutomatically = true
    }
    
    func constraintsTF() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: navbar.bottomAnchor),
            textView.leftAnchor.constraint(equalTo: view.leftAnchor),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
    
    
    @objc func closePlusVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    private func addSubViews() {
        view.addSubview(navbar)
        view.addSubview(textView)
    }

}
