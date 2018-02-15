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
    
    var actors = [Actor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client.getActors(page: "1") { [unowned self] result in
            switch result {
            case .success(let actors):
                self.actors = actors
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
        return actors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath) as! ActorTableViewCell

        cell.nameLabel.text = actors[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }

    

    @IBAction func donePushed(_ sender: UIBarButtonItem) {
        let selectionvc = self.storyboard!.instantiateViewController(withIdentifier: "SelectionView")
        if User1.isSelected {
            User1.isReady = true
        } else if User2.isSelected {
            User2.isReady = true
        }
        present(selectionvc, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
