//
//  MovieTableViewController.swift
//  Movie Night
//
//  Created by Garrett Votaw on 2/20/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {

    
   
    lazy var client = {
       return MovieDBClient()
    }()
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        client.getMovies(actors: MovieSorter.sortedActorPreferences.formattedForMovieRequest, genres: MovieSorter.sortedGenrePreferences.formattedForMovieRequest) { [unowned self] result in
            switch result {
            case .success(let movies):
                self.movies = movies
                if self.movies.isEmpty {
                    AlertController.presentAlert(withView: self, title: "Error", message: "Unable to find movies with both user preferences")
                }
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
        return movies.count
    }

    @IBAction func donePushed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        User1.isReady = false
        User2.isReady = false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        cell.TitleLabel.text = movies[indexPath.row].title
        cell.overviewLabel.text = movies[indexPath.row].overview
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/YYYY"
        let stringDate = formatter.string(from: movies[indexPath.row].releaseDate)
        cell.releaseDateLabel.text = stringDate
        return cell
    }

}
