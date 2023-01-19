//
//  DetailViewController.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private var tableView: UITableView!
    
    private let characters: [String]
    
    // MARK: - Init
    init(characters: [String]) {
        self.characters = characters
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
    }
    
    // MARK: - Helpers
    @objc func doneButtonTapped() {
        dismiss(animated: true)
    }
    
    private func configureNavBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
        title = "Characters"
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: .detailTableViewCellReuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .detailTableViewCellReuseIdentifier, for: indexPath as IndexPath)
        cell.textLabel?.text = characters[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentAlert(title: "Feature not implemented", message: "We haven't got that far yet!", buttonTitle: "Ok")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension String {
    static let detailTableViewCellReuseIdentifier = "detailReusableIdentifier"
}
