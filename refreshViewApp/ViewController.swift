//
//  ViewController.swift
//  refreshViewApp
//
//  Created by Anantha Krishnan K G on 18/05/17.
//  Copyright © 2017 Ananth. All rights reserved.
//

import UIKit

struct Hotels {
    let name: String
    let place: String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var hotels = [
        Hotels(name: "Fairmont Grand Del Mar", place: "California south"),
        Hotels(name: "The Beverly Hills Hotel", place: "California south")
    ]
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.addSubview(self.refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        let newHotel = Hotels(name: "Montage Laguna Beach", place: "California south")
        hotels.append(newHotel)
        
        hotels.sort() { $0.name < $1.place }
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = hotels[(indexPath as NSIndexPath).row].name
        cell.detailTextLabel?.text = hotels[(indexPath as NSIndexPath).row].place
        
        return cell
    }


}

