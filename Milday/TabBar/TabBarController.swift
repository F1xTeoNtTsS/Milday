//
//  TabBarController.swift
//  Milday
//
//  Created by Dmitrii Abanin on 4/26/21.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
        
    let middleButton = MiddleButton()
    let listVC = ListViewController()
    let calendarVC = CalendarViewController()
    let plusVC = PlusViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.delegate = self
        //self.selectedIndex = 1
        
        viewControllers = [
            setNavigationVC(rootViewController: listVC, title: "LIST", image: Icons.mainTabIcon!),
            setNavigationVC(rootViewController: calendarVC, title: "CALENDAR", image: Icons.secondTabIcon!)
        ]
        
        let btn = middleButton.setupMiddleButton(view: view, tabbar: tabBar)
        btn.addTarget(self, action: #selector(openPlusVC), for: .touchUpInside)
    }
    
    private func setNavigationVC(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        let item = UITabBarItem()
        
        item.title = title
        item.image = image
        navigationVC.tabBarItem = item
        return navigationVC
    }
    
    
    
    @objc func openPlusVC(sender: UIButton) {
        
        plusVC.delegate = self
        
        self.present(plusVC, animated: true, completion: nil)
        
        
        
    }
    
    @objc func handleOpenVC() {
        
    }
}

extension TabBarController: AddDayDelegate {
    func addDay(day: Day) {
        plusVC.dismiss(animated: true) {
            self.listVC.days.append(day)
            self.listVC.tableView.reloadData()
        }
    }
    
    
    
}
