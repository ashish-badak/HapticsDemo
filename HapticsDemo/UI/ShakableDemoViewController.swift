//
//  ShakableDemoViewController.swift
//  HapticsDemo
//
//  Created by Ashish Badak on 25/01/23.
//

import UIKit

enum ShakeFeedback: CaseIterable {
    case horizontal, vertical
    
    var title: String {
        switch self {
        case .horizontal: return "Shake Horizontally"
        case .vertical: return "Shake Vertically"
        }
    }
    
    var shakeAxis: ShakeAxis {
        switch self {
        case .horizontal: return ShakeAxis.horizontal
        case .vertical: return ShakeAxis.veritcal
        }
    }
}

class ShakableDemoViewController: UIViewController {
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Shakable View Demo"
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.register(
            HapticsFeedbackTableViewCell.self,
            forCellReuseIdentifier: HapticsFeedbackTableViewCell.reuseId
        )
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ShakableDemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ShakeFeedback.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HapticsFeedbackTableViewCell.reuseId, for: indexPath) as? HapticsFeedbackTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.setTitle(ShakeFeedback.allCases[indexPath.row].title)
        return cell
    }
}

extension ShakableDemoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) as? ShakableView {
            cell.shake(
                on: ShakeFeedback.allCases[indexPath.row].shakeAxis,
                repeatCount: Float(indexPath.row + 1),
                for: 0.1,
                withTranslation: 5
            )
        }
    }
}
