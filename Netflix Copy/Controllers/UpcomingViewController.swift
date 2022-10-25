//
//  UpcomingViewController.swift
//  Netflix Copy
//
//  Created by Mariusz Zając on 23/10/2022.
//

import UIKit

class UpcomingViewController: UIViewController {

    private var titles: [Title] = [Title]()
    
    private let upcominaTable: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcominaTable)
        upcominaTable.delegate = self
        upcominaTable.dataSource = self
        
        fetchUpcoming()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcominaTable.frame = view.bounds
    }
  
    private func fetchUpcoming () {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcominaTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}
extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "unknown"
        return cell
    }
}
