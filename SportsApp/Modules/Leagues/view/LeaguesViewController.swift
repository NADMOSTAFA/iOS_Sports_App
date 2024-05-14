//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Nada Mostafa on 11/05/2024.
//

import UIKit

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
            print("Enter")
            DispatchQueue.main.async {
                self?.indicator?.stopAnimating()
                self?.leaguesTableView.reloadData()
            }
        }
        
            
//        network.fetchData(from: homeViewMode!.getSportType()!, parameters: ["met":"Leagues"]) { (result: Result<APIResponse<League>, Error>) in
//            switch result {
//            case .success(let leagues):
//                // Handle successful data retrieval
//                self.leagueList = leagues.result!
//                self.leaguesTableView.reloadData()
//                print("Teams fetched successfully: \(String(describing: self.leagueList!.count))")
//            case .failure(let error):
//                // Handle error
//                print("Error fetching teams: \(error)")
//            }
//        }
        
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
        if leaguesViewModel.getLeaguesCount() > 0 {
             cell.leagueName.text = leaguesViewModel.getLeagues()[indexPath.row].leagueName
            //cell.leagueLogo.image = leagueList![indexPath.row].leagueLogo
        }
        
        
       return cell
    }
    
    
}

extension LeaguesViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Isra Entry Point :)
        
        let leagueDetails = self.storyboard?.instantiateViewController(identifier: "leagueDetails") as! LeagueDetailsViewController
        leaguesViewModel.setEndPoint(endPoint: (homeViewModel?.getSportType())!)
        leaguesViewModel.setselectedLeague(league: leaguesViewModel.getLeagues()[indexPath.row])
        leagueDetails.leaguesViewModel = self.leaguesViewModel
        self.present(leagueDetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}
