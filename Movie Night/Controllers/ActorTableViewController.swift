//
//  ActorTableViewController.swift
//  Movie Night
//
//  Created by Garrett Votaw on 1/31/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import UIKit

class ActorTableViewController: UITableViewController {

    lazy var client: MovieDBClient = {
        return MovieDBClient()
    }()
    
    @IBOutlet weak var counterLabel: UILabel!
    var actors = [Actor]()
    var totalSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        getActorsThrough(page: 3)
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
        return actors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath) as! ActorTableViewCell
        actors.sort{$0.name < $1.name}
        let movies = actors[indexPath.row].associatedMovies
        var titles = [String]()
        for movie in movies {
            titles.append(movie.title)
        }
        cell.associatedMoviesLabel.text = titles.prettyPrinted
        cell.nameLabel.text = actors[indexPath.row].name

        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actors[indexPath.row].isSelected = true
        totalSelected += 1
        counterLabel.text = "\(totalSelected) of 5 Selected"
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        actors[indexPath.row].isSelected = false
        totalSelected -= 1
        counterLabel.text = "\(totalSelected) of 5 Selected"
    }

    @IBAction func donePushed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
        if User1.isSelected {
            for actor in actors {
                if actor.isSelected {
                    User1.actorPreferences.append(actor.id)
                }
            }
            User1.isReady = true
        } else if User2.isSelected {
            for actor in actors {
                if actor.isSelected {
                    User2.actorPreferences.append(actor.id)
                }
            }
            User2.isReady = true
        }
        
    }
    
    func getActorsThrough(page: Int) {
        var pageCounter = 1
        while pageCounter <= page {
            client.getActors(page: "\(pageCounter)") {[unowned self] result in
                switch result {
                case .success(let actors):
                    self.actors += actors
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            pageCounter += 1
        }
    }
}

extension Array {
    var prettyPrinted: String {
        var prettyString = ""
        for i in self {
            prettyString.append("\(i)\n")
        }
        return prettyString
    }
}
