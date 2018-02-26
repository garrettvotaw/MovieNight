//
//  GenreTableViewController.swift
//  Movie Night
//
//  Created by Garrett Votaw on 1/31/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import UIKit


class GenreTableViewController: UITableViewController{
    
    lazy var client: MovieDBClient = {
       return MovieDBClient()
    }()
    
    @IBOutlet weak var selectionHelperLabel: UILabel!
    var genres = [Genre]()
    var totalSelected = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client.getGenres { result in
            switch result {
            case .success(let genres):
                self.genres = genres
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath) as! GenreTableViewCell
        cell.nameLabel.text = genres[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        genres[indexPath.row].isSelected = true
        totalSelected += 1
        selectionHelperLabel.text = "\(totalSelected) of 3 selected"
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        genres[indexPath.row].isSelected = true
        totalSelected -= 1
        selectionHelperLabel.text = "\(totalSelected) of 3 selected"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
