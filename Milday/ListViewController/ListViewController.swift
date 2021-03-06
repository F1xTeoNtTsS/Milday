//
//  ListViewController.swift
//  Milday
//
//  Created by Dmitrii Abanin on 4/19/21.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    let manageData = ManageData()
    let cellId = "cell"
    var daysCD: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subviews()
        setupTableView()
        constraints()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        manageData.fetchData(object: &daysCD)
    }
    
    let tableView = UITableView()
    
    func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "List of mildays"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18) ?? ""]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 24) ?? ""]
    }
    
    func setupTableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ListViewController {
    func subviews() {
        view.addSubview(tableView)
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return days.count
        return daysCD.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let day = daysCD[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        cell.configureCell(day: day)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let day = daysCD[indexPath.row]
        let showVC = ShowViewController(day: day)
        
        showVC.completion = { [weak self] text in
            DispatchQueue.main.async {
                do {
                    day.setValue(text, forKey: "text")
                    tableView.reloadData()
                    try self!.manageData.context.save()
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        
        self.present(showVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let day = daysCD[indexPath.row] as? DayCD, editingStyle == .delete else { return }
        
        manageData.context.delete(day)
        
        do {
            try manageData.context.save()
            daysCD.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
