//
//  PlusViewController.swift
//  Milday
//
//  Created by Dmitrii Abanin on 4/27/21.
//

import UIKit
import CoreData

protocol AddDayDelegate {
    func addDay(date: String, text: String)
}

class PlusViewController: UIViewController {
    
    var delegate: AddDayDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTV.textView.delegate = self
        setupView()
        
        customTV.setupTextView()
        customTV.constraintsTextView(view: view, navbar: navbar)
        
        keyboardNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        customTV.startEditing()
        textViewDidChange(customTV.textView)
    }
    
    private let navbar = UINavigationBar()
    private let customTV = CustomTextView()
    private let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneEdit))
    
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
            customTV.textView.contentInset = .zero
        } else {
            customTV.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height + 40 - view.safeAreaInsets.bottom, right: 0)
        }
        
        customTV.textView.scrollIndicatorInsets = customTV.textView.contentInset
        
        let selectedRange = customTV.selectedRange
        customTV.textView.scrollRangeToVisible(selectedRange)
        
        customTV.textView.keyboardDismissMode = .interactive
    }
    
    func setupNavigationBar() {
        
        navbar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        navbar.backgroundColor = .clear
        
        navbar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.systemGreen]
        
        
        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closePlusVC))
        navItem.rightBarButtonItem = doneButton
        navItem.title = "New awesome day"
        doneButton.isEnabled = false
        navbar.items = [navItem]
    }
    
    @objc func closePlusVC() {
        
        let closeButtonAlert = UIAlertController(title: "Unsaved Changes", message: "Are you sure you want to Close?", preferredStyle: UIAlertController.Style.alert)
        
        closeButtonAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            self.dismiss(animated: true, completion: nil)
            self.customTV.textView.text.removeAll()
            self.textViewDidChange(self.customTV.textView)
        }))
        closeButtonAlert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default))
        
        if customTV.textView.text?.isEmpty == false {
            self.present(closeButtonAlert, animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func doneEdit() {
        
        guard let text = customTV.textView.text, customTV.textView.hasText else { print("Handle error")
            return
        }
        
        saveDay(text: text)
        
        customTV.textView.text.removeAll()
        textViewDidChange(customTV.textView)
    }

    private func saveDay(text: String) {
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        let date = formatter.string(from: currentDate)
        
        delegate?.addDay(date: date, text: text)
    }
    
    private func setupView() {
        setupNavigationBar()
        addSubViews()
        
        isModalInPresentation = true
        view.backgroundColor = customTV.backgroundColor
    }
    
    private func addSubViews() {
        view.addSubview(navbar)
        view.addSubview(customTV.textView)
    }
}

extension PlusViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if customTV.textView.text?.isEmpty == false {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
    }
}
