//
//  ViewController.swift
//  StarWars
//
//  Created by Nov Petrović on 16/01/2023.
//

import UIKit

final class ListViewController: UIViewController {
    
    // MARK: - Properties
    private var filmsList = [FilmModel]()
    private var characterList = [CharacterModel]()
    private var characterDict = [String: String]()
    private var filteredFilmList = [FilmModel]()
    
    private var tableView: UITableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        fetchFilms()
        fetchCharacters()
    }
}

private extension ListViewController {
    func configureView() {
        title = "Star Wars Films"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func fetchFilms() {
        NetworkManager.shared.fetchFilmList { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                self.filmsList = data.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                return

            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.localizedDescription, buttonTitle: "Ok")
                return
            }
        }
    }
    
    func fetchCharacters() {
        NetworkManager.shared.fetchCharacterList { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let data):
                self.characterList = data.results
                self.createCharacterDictionary()
                return

            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.localizedDescription, buttonTitle: "Ok")
                return
            }
        }
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.reuseId)
    }
    
    private func createCharacterDictionary() {
        for character in characterList {
            characterDict[character.url] = character.name
        }
    }

    private func convertCharacterUrlsToNames(for film: FilmModel) -> [String] {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.reuseId, for: indexPath as IndexPath)
        cell.textLabel?.text = filmsList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let film = filmsList[indexPath.row]
        let characters = convertCharacterUrlsToNames(for: film)
        
        let detailViewController = DetailViewController(characters: characters)
        let navController = UINavigationController(rootViewController: detailViewController)
        present(navController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
