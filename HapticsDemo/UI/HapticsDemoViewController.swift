//
//  HapticsDemoViewController.swift
//  HapticsDemo
//
//  Created by Ashish Badak on 25/01/23.
//

import UIKit

enum HapticFeedback: CaseIterable {
    case error, warning, success, soft, light, rigid, medium, heavy, selection
    
    var title: String {
        switch self {
        case .error: return "Error Notification Haptic"
        case .warning: return "Warning Notification Haptic"
        case .success: return "Success Notification Haptic"
        case .soft: return "Soft Intensity Haptic"
        case .light: return "Light Intensity Haptic"
        case .rigid: return "Rigid Intensity Haptic"
        case .medium: return "Medium Intensity Haptic"
        case .heavy: return "Heavy Intensity Haptic"
        case .selection: return "Selection Haptic"
        }
    }
}

final class HapticsDemoViewController: UIViewController {
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
        self.tabBarController?.title = "Haptics Demo"
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

extension HapticsDemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HapticFeedback.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HapticsFeedbackTableViewCell.reuseId, for: indexPath) as? HapticsFeedbackTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.setTitle(HapticFeedback.allCases[indexPath.row].title)
        return cell
    }
}

extension HapticsDemoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch HapticFeedback.allCases[indexPath.row] {
        case .error: Haptics.notify(.error)
        case .warning: Haptics.notify(.warning)
        case .success: Haptics.notify(.success)
        case .soft: Haptics.markImpact(intensity: .soft)
        case .light: Haptics.markImpact(intensity: .light)
        case .rigid: Haptics.markImpact(intensity: .rigid)
        case .medium: Haptics.markImpact(intensity: .medium)
        case .heavy: Haptics.markImpact(intensity: .heavy)
        case .selection: Haptics.selectionEffect()
        }
    }
}
