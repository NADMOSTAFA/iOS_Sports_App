//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Israa on 11/05/2024.
//

import UIKit

class TeamDetailsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamCoachName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    
    var viewModel : TeamDetailsViewModel?
    var leagueDetailsViewModel : LeagueDetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TeamDetailsViewModel(network: NetworkService.instance, teamId: leagueDetailsViewModel?.getselectedTeam().teamKey)
        
        

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
            return viewModel?.getPlayersCount()
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! PlayerCollectionViewCell

        
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
