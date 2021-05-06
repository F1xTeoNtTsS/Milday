//
//  ListViewController.swift
//  Milday
//
//  Created by Dmitrii Abanin on 4/19/21.
//

import UIKit

class ListViewController: UIViewController {
    
    let days = [
        Day(date: "06.05.21", description: "Happy day", text: "Some text for example")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subviews()
        setupTableView()
        constraints()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "List of mildays"
        
    }
    
    private let tableView = UITableView()

    
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
        
        cell.textLabel?.text = days[indexPath.row].date + " - \(days[indexPath.row].description)"
        cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
    
        
        return cell
    }


}
