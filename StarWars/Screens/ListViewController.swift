//
//  ViewController.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import UIKit

final class ListViewController: BUDataLoadingVC {
    
    // MARK: - Properties
    var networkManager: NetworkManagerProtocol
    var filmsList = [FilmModel]()
    var characterList = [CharacterModel]()
    var characterDict = [String: String]()
    private var filteredFilmList = [FilmModel]()
    private var charactersLoaded = false
    
    private var tableView: UITableView!
    private var loadingView: UIActivityIndicatorView!
    private var refreshControl: UIRefreshControl!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        configureLoadingView()
        configureRefreshControl()
        fetchFilms()
        fetchCharacters()
    }
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ListViewController {
    private func configureView() {
        title = "Star Wars Films"
    }

    private func fetchFilms() {
        showLoadingView()
        Task {
            do {
                let data = try await NetworkManager.shared.fetchFilmList()
                filmsList = data.results
                tableView.reloadData()
                dismissLoadingView()
            } catch {
                if let buError = error as? NetworkError {
                    presentAlert(title: "Something went wrong", message: buError.localizedDescription, buttonTitle: "Ok")
                } else {
                    presentDefaultAlert()
                }
                dismissLoadingView()
            }
            refreshControl.endRefreshing()
        }
    }
    
    private func fetchCharacters() {
        Task {
            do {
                let data = try await NetworkManager.shared.fetchCharacterList()
                characterList = data.results
                createCharacterDictionary(for: characterList)
                charactersLoaded = true
            } catch {
                if let buError = error as? NetworkError {
                    presentAlert(title: "Something went wrong", message: buError.localizedDescription, buttonTitle: "Ok")
                } else {
                    presentDefaultAlert()
                }
            }
        }
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: .listTableViewCellReuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    private func configureLoadingView() {
        loadingView = UIActivityIndicatorView()
        loadingView.style = .large
        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
    }
    
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        fetchFilms()
    }
    
    func createCharacterDictionary(for characterList: [CharacterModel]) {
        for character in characterList {
            characterDict[character.url] = character.name
        }
    }

    func convertCharacterUrlsToNames(for film: FilmModel) -> [String] {
        var output = [String]()
        for characterURL in film.characters {
            if let characterName = characterDict[characterURL] {
                output.append(characterName)
            }
        }
        return output
    }
}

// MARK: - TableView
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .listTableViewCellReuseIdentifier, for: indexPath as IndexPath)
        cell.textLabel?.text = filmsList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if charactersLoaded {
            let film = filmsList[indexPath.row]
            let characters = convertCharacterUrlsToNames(for: film)
            let detailViewController = DetailViewController(characters: characters)
            let navController = UINavigationController(rootViewController: detailViewController)
            present(navController, animated: true)
        } else {
            presentAlert(title: "Could not load characters at this time", message: "Please try again.", buttonTitle: "Ok")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension String {
    static let listTableViewCellReuseIdentifier = "listReusableIdentifier"
}
