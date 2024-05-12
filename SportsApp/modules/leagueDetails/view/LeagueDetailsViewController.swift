//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Israa on 11/05/2024.
//

import UIKit

class LeagueDetailsViewController: UIViewController {

    @IBOutlet weak var detailsCollectionView: UICollectionView!
    @IBOutlet weak var leagueTitle: UILabel!
    var leaguesViewModel  : LeaguesViewModelProtocol?
    var leagueDetailsViewModel  = LeagueDetailsViewModel(network: NetworkService.instance)

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leagueDetailsViewModel.loadUpcomingFixture(endPoint: leaguesViewModel!.getEndPoint(), leagueID: (leaguesViewModel?.getselectedLeague().leagueKey)!)
        leagueDetailsViewModel.loadLatestResults(endPoint: leaguesViewModel!.getEndPoint(), leagueID: (leaguesViewModel?.getselectedLeague().leagueKey)!)
        leagueDetailsViewModel.loadTeams(endPoint: leaguesViewModel!.getEndPoint(), leagueID: (leaguesViewModel?.getselectedLeague().leagueKey)!)
        leagueTitle.text = leaguesViewModel?.getselectedLeague().leagueName
   
        
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        
    }
    
    @IBAction func saveLeague(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
