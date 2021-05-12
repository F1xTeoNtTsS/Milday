//
//  ListViewController.swift
//  Milday
//
//  Created by Dmitrii Abanin on 4/19/21.
//

import UIKit

class ListViewController: UIViewController {
    
    var days: [Day] = []
    let cellId = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subviews()
        setupTableView()
        constraints()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "List of mildays"
        
        days.append(Day(date: "28.10.92", description: "Wonderful day", text: "Wonderfull day, because i was born"))
        days.append(Day(date: "28.10.20", description: "Another wonderfull day", text: "Some Day"))
        days.append(Day(date: "09.01.21", description: "Sad day", text: "Another day, little sad"))
        
        
    }
    
    let tableView = UITableView()

    
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
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        
        let currentLastItem = days[indexPath.row]
        cell.day = currentLastItem
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let day = days[indexPath.row]
        let showVC = ShowViewController(day: day)
        
        showVC.completion = { [weak self] text in
            DispatchQueue.main.async {
                self?.days[indexPath.row].text = text!
                tableView.reloadData()
            }
        }
        
        self.present(showVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
