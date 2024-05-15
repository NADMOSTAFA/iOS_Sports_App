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
            if(self?.favoriteViewModel.getLeaguesCount() == 0){
                self?.favoriteTableView.isHidden = true
            }else{
                self?.favoriteTableView.isHidden = false
                self?.favoriteTableView.reloadData()
            }
                
           // }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let view = self.navigationController!.visibleViewController;
        view!.navigationItem.title = "Favorite Leagues"
        
        if(favoriteViewModel.getLeaguesCount() == 0){
            favoriteTableView.isHidden = true
        }else{
            favoriteTableView.isHidden = false
            favoriteTableView.reloadData()
        }
    }
}


extension FavoriteViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return favoriteViewModel.getLeaguesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell", for: indexPath) as! LeagueTableViewCell
        cell.accessoryType = .disclosureIndicator
        if favoriteViewModel.getLeaguesCount() > 0 {
            let league = favoriteViewModel.getLeagues()[indexPath.row]
            cell.setUp(league: league)
        }
       return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
    }
    
    
}

extension FavoriteViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if NetworkAvailibility.isConnected() {
            let leagueDetails = self.storyboard?.instantiateViewController(identifier: "leagueDetails") as! LeagueDetailsViewController
            //MARK: - Sould be Removed
            //favoriteViewModel.setEndPoint(endPoint: (EndPoints.football.rawValue))
            //
            // MARK: - Added
            favoriteViewModel.getLeagues()[indexPath.row].sportType = favoriteViewModel.getEndPoint()
            //End
            favoriteViewModel.setselectedLeague(league: favoriteViewModel.getLeagues()[indexPath.row])
            print(favoriteViewModel.getLeagues()[indexPath.row].leagueName!)
            leagueDetails.leaguesViewModel = self.favoriteViewModel
            self.present(leagueDetails, animated: true)
        }else{
            let alertController = UIAlertController(title: "Error!", message: "No Internet Connection", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height * 0.08
    }
}
