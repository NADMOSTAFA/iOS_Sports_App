//
//  FavoriteViewController.swift
//  SportsApp
//
//  Created by Apple on 14/05/2024.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var favoriteTableView: UITableView!
    let favoriteViewModel =  FavoriteViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        favoriteTableView.register(LeagueTableViewCell.nib(), forCellReuseIdentifier: "LeagueTableViewCell")
        
        favoriteViewModel.loadData(endPoint: "")
        favoriteViewModel.bindLeaguesToViewController = {[weak self] in
            print("Enter")
            //DispatchQueue.main.async {
                self?.favoriteTableView.reloadData()
           // }
        }
        
    }
}


extension FavoriteViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return favoriteViewModel.getLeaguesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell", for: indexPath) as! LeagueTableViewCell
        if favoriteViewModel.getLeaguesCount() > 0 {
             cell.leagueName.text = favoriteViewModel.getLeagues()[indexPath.row].leagueName
            //cell.leagueLogo.image = leagueList![indexPath.row].leagueLogo
        }
       return cell
    }
    
    
}

extension FavoriteViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetails = self.storyboard?.instantiateViewController(identifier: "leagueDetails") as! LeagueDetailsViewController
        //MARK: - Sould be Removed
        favoriteViewModel.setEndPoint(endPoint: (EndPoints.football.rawValue))
        //
        // MARK: - Added
        favoriteViewModel.getLeagues()[indexPath.row].sportType = favoriteViewModel.getEndPoint()
        //End
        favoriteViewModel.setselectedLeague(league: favoriteViewModel.getLeagues()[indexPath.row])
        print(favoriteViewModel.getLeagues()[indexPath.row].leagueName!)
        leagueDetails.leaguesViewModel = self.favoriteViewModel
        self.present(leagueDetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}
