//
//  GenreTableViewController.swift
//  Movie Night
//
//  Created by Garrett Votaw on 1/31/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import UIKit


class GenreTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    lazy var client: MovieDBClient = {
       return MovieDBClient()
    }()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectionHelperLabel: UILabel!
    var genres = [Genre]()
    var totalSelected = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        client.getGenres { result in
            switch result {
            case .success(let genres):
                self.genres = genres
                self.tableView.reloadData()
            case .failure(let error):
                AlertController.presentAlert(withView: self, title: "Error", message: "\(error)")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath) as! GenreTableViewCell
        cell.nameLabel.text = genres[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        genres[indexPath.row].isSelected = true
        totalSelected += 1
        selectionHelperLabel.text = "\(totalSelected) of 4 selected"
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        genres[indexPath.row].isSelected = true
        totalSelected -= 1
        selectionHelperLabel.text = "\(totalSelected) of 4 selected"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if User1.isSelected {
            for genre in genres {
                if genre.isSelected {
                    User1.genrePreferences.append(genre.id)
                }
            }
        } else {
            for genre in genres {
                if genre.isSelected {
                    User2.genrePreferences.append(genre.id)
                }
            }
        }
    }
}
