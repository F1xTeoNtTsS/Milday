//
//  ListViewController.swift
//  Milday
//
//  Created by Dmitrii Abanin on 4/19/21.
//

import UIKit

class ListViewController: UIViewController {
    
    var days: [Day] = [Day(date: "11111", description: "qwerty", text: "ytrewq")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subviews()
        setupTableView()
        constraints()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "List of mildays"
        
        
    }
    
    let tableView = UITableView()

    
    func setupTableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let day = days[indexPath.row]
        
        cell.textLabel?.text = day.date + " - \(day.description)"
        cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
    
        
        return cell
    }


}
