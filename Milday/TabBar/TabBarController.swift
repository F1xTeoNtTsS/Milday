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
    let showVC = ShowViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.delegate = self
        
        viewControllers = [
            setNavigationVC(rootViewController: listVC, title: "LIST", image: Icons.listTabIcon!),
            setNavigationVC(rootViewController: calendarVC, title: "CALENDAR", image: Icons.calendarTabIcon!)
        ]
        
        let btn = middleButton.setupMiddleButton(view: view, tabbar: tabBar)
        btn.addTarget(self, action: #selector(openPlusVC), for: .touchUpInside)
    }

    @objc func openPlusVC(sender: UIButton) {
        
        plusVC.delegate = self
        
        self.present(plusVC, animated: true, completion: nil)
    }
    
    private func setNavigationVC(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        let item = UITabBarItem()
        
        item.title = title
        item.image = image
        navigationVC.tabBarItem = item
        
        
        return navigationVC
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.listVC.tableView.scrollToTop()
    }
}

extension TabBarController: AddDayDelegate {
    func addDay(day: Day) {
        plusVC.dismiss(animated: true) {
            self.listVC.days.append(day)
            self.listVC.tableView.reloadData()
            self.listVC.tableView.scrollToBottom()
        }
    }
}
