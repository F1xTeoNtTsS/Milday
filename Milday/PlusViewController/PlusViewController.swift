//
//  PlusViewController.swift
//  Milday
//
//  Created by Dmitrii Abanin on 4/27/21.
//

import UIKit

class PlusViewController: UIViewController {

    private let navbar = UINavigationBar()
    private let customTextView = CustomTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        customTextView.setupTextView()
        customTextView.constraintsTextView(view: view, navbar: navbar)
        
        keyboardNotification()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        customTextView.startEditing()
    }
    
    private func keyboardNotification() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            customTextView.textView.contentInset = .zero
        } else {
            customTextView.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height + 40 - view.safeAreaInsets.bottom, right: 0)
        }

        customTextView.textView.scrollIndicatorInsets = customTextView.textView.contentInset

        let selectedRange = customTextView.selectedRange
        customTextView.textView.scrollRangeToVisible(selectedRange)
        
        customTextView.textView.keyboardDismissMode = .interactive
    }

    func setupView() {
        setupNavigationBar()
        addSubViews()
        
        isModalInPresentation = true
        view.backgroundColor = customTextView.backgroundColor
    }
    
    func setupNavigationBar() {
        
        navbar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        navbar.backgroundColor = .none

        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closePlusVC))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)

        navbar.items = [navItem]
    }
    
    @objc func closePlusVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    private func addSubViews() {
        view.addSubview(navbar)
        view.addSubview(customTextView.textView)
    }

}
