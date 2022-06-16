//
//  FeedViewController.swift
//  Firebase Project
//
//  Created by Emin Emini on 16.06.2022..
//

import UIKit
import Firebase

class FeedViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var feedTableView: UITableView!
    
    // MARK: - Properties
    let refreshControl = UIRefreshControl()
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true)
        } catch let error {
            print("Error: ", error.localizedDescription)
        }
    }
    

}

// MARK: - Refresh Functions
extension FeedViewController {
    func setUpRefreshAction() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        feedTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        feedTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}

//MARK: - Table View
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

