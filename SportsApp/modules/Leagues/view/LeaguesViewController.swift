//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Nada Mostafa on 11/05/2024.
//

import UIKit

class LeaguesViewController: UIViewController {
    @IBOutlet weak var leaguesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaguesTableView.dataSource = self
        leaguesTableView.delegate = self
        leaguesTableView.register(LeagueTableViewCell.nib(), forCellReuseIdentifier: "LeagueTableViewCell")
        
    }

}


extension LeaguesViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension LeaguesViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}
