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
        reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let view = self.navigationController!.visibleViewController;
        view!.navigationItem.title = "Favorite Leagues"
        favoriteViewModel.loadData(endPoint: "")
        favoriteViewModel.bindLeaguesToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.reload()
            }
        }
        reload()
    }
    
    func reload()  {
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
            print("favorite")
            print(".................." + String(favoriteViewModel.getLeaguesCount()))
            print(".................." + (league.leagueName ?? ""))
            print(".................." + league.sportType!)
            cell.setUp(league: league)
        }
       return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            self.setConfirmationAlert(indexPath: indexPath)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "tarsh")
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfiguration
        
    }
    
    func setConfirmationAlert(indexPath : IndexPath){
        let alert = UIAlertController(title: "Confirmation Required", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Ok", style: .default) { action in
            self.favoriteViewModel.deleteStroedLeague(league: self.favoriteViewModel.getLeagues()[indexPath.row],index: indexPath.row)
            self.favoriteTableView.reloadData()
            self.reload()
        }
        let btnCancel = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(btnOk)
        alert.addAction(btnCancel)
        self.present(alert, animated: true)
    }
}

extension FavoriteViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if NetworkAvailibility.isConnected() {
            let leagueDetails = self.storyboard?.instantiateViewController(identifier: "leagueDetails") as! LeagueDetailsViewController
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
