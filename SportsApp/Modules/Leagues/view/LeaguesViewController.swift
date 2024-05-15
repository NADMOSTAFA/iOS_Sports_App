//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Nada Mostafa on 11/05/2024.
//

import UIKit
import Kingfisher

class LeaguesViewController: UIViewController {
    @IBOutlet weak var leaguesTableView: UITableView!
    var leaguesViewModel  = LeaguesViewModel(network: NetworkService.instance)
    var homeViewModel : HomeViewModelProtocol?
    var indicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesTableView.dataSource = self
        leaguesTableView.delegate = self
        leaguesTableView.register(LeagueTableViewCell.nib(), forCellReuseIdentifier: "LeagueTableViewCell")
        
        setIndicator()
        leaguesViewModel.loadData(endPoint: homeViewModel!.getSportType()!)
        leaguesViewModel.bindLeaguesToViewConreoller = {[weak self] in
            DispatchQueue.main.async {
                self?.indicator?.stopAnimating()
                self?.leaguesTableView.reloadData()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let view = self.navigationController!.visibleViewController;
        view!.navigationItem.title = "Leagues"
    }
    
    func setIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
    }

}


extension LeaguesViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesViewModel.getLeaguesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell", for: indexPath) as! LeagueTableViewCell
        cell.accessoryType = .disclosureIndicator
        if leaguesViewModel.getLeaguesCount() > 0 {
            let league = leaguesViewModel.getLeagues()[indexPath.row]
            league.sportType  =  homeViewModel?.getSportType()
            cell.setUp(league: league)
        }
        
        
       return cell
    }
     
}

extension LeaguesViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if NetworkAvailibility.isConnected(){
            let leagueDetails = self.storyboard?.instantiateViewController(identifier: "leagueDetails") as! LeagueDetailsViewController
            let league = leaguesViewModel.getLeagues()[indexPath.row]
            if(league.leagueLogo == nil){
                league.leagueLogo = ""
            }
            leaguesViewModel.setselectedLeague(league: league)
            leagueDetails.leaguesViewModel = self.leaguesViewModel
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
