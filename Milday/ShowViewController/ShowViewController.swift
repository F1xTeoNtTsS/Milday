//
//  ShowViewController.swift
//  Milday
//
//  Created by F1xTeoNtTsS on 10.05.2021.
//

import UIKit
import CoreData

class ShowViewController: UIViewController {
    
    public var completion: ((String?) -> Void)?
    
    private var day: NSManagedObject?
    
    init(day: NSManagedObject) {
            self.day = day
           
        super.init(nibName: nil, bundle: nil)
        }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customTV.textView.delegate = self
        setupView()
        
        customTV.setupTextView()
        customTV.constraintsTextView(view: view, navbar: navbar)
        
        keyboardNotification()
        customTV.textView.text = day?.value(forKey: "text") as? String
    }
    
    private let navbar = UINavigationBar()
    private let customTV = CustomTextView()
    
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
        navbar.backgroundColor = .none
        navbar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.systemGreen]

        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeShowVC))
        navItem.leftBarButtonItem?.tintColor = UIColor.systemGreen
        navItem.title = day?.value(forKey: "text") as? String
        navbar.items = [navItem]
    }
    
    @objc func closeShowVC() {
        
        guard let text = customTV.textView.text, customTV.textView.hasText else {
            self.dismiss(animated: true, completion: nil)
            return editDay(text: "")
        }

        editDay(text: text)
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    private func editDay(text: String) {
        completion?(text)
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

extension ShowViewController: UITextViewDelegate {

}
