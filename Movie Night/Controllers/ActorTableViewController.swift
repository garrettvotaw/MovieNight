//
//  ActorTableViewController.swift
//  Movie Night
//
//  Created by Garrett Votaw on 1/31/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import UIKit

class ActorTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    lazy var client: MovieDBClient = {
        return MovieDBClient()
    }()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var counterLabel: UILabel!
    var actors = [Actor]()
    var totalSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        getActorsThrough(page: 3)
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
        return actors.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actors[indexPath.row].isSelected = true
        totalSelected += 1
        counterLabel.text = "\(totalSelected) of 5 Selected"
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        actors[indexPath.row].isSelected = false
        totalSelected -= 1
        counterLabel.text = "\(totalSelected) of 5 Selected"
    }

    @IBAction func donePushed(_ sender: UIBarButtonItem) {
        if totalSelected == 0 {
            AlertController.presentAlert(withView: self, title: "Error", message: "You have not selected any actors. Please select at least one.")
        } else if totalSelected > 5 {
            AlertController.presentAlert(withView: self, title: "Error", message: "Please select 5 or less actors from the list")
        } else {
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
                    AlertController.presentAlert(withView: self, title: "Error", message: "\(error)")
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
