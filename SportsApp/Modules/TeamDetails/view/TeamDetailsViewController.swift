//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Israa on 11/05/2024.
//

import UIKit
import Kingfisher
import Alamofire

class TeamDetailsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamCoachName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var playerCollectionView: UICollectionView!

    
    var viewModel : TeamDetailsViewModel?
    var leagueDetailsViewModel : LeagueDetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        playerCollectionView.dataSource = self
              playerCollectionView.delegate = self
              
        viewModel = TeamDetailsViewModel(network: NetworkService.instance, teamId: leagueDetailsViewModel?.getselectedTeam().teamKey)
        
        print(leagueDetailsViewModel?.getselectedTeam().teamKey)
    
        
        
        viewModel?.loadTeamData()
        viewModel?.bindTeamData =  {   
            print("Enter Team Data")
            DispatchQueue.main.async {
                self.playerCollectionView.reloadData()
                self.teamCoachName.text = self.viewModel?.getCoachAtIndex(index: 0).coachName

            }
        }
        
        let layout = UICollectionViewCompositionalLayout{
                    (section , enviroment) in
                    
                    let section = self.drawSection()
            
                    return section
                }
                playerCollectionView.setCollectionViewLayout(layout, animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.teamName.text =  leagueDetailsViewModel?.getselectedTeam().teamName
    
        if let teamURLString = leagueDetailsViewModel?.getselectedTeam().teamLogo
          , let teamURL = URL(string: teamURLString) {
            self.teamLogo.kf.setImage(with: teamURL)
        } else {
            self.teamLogo.image = UIImage(named: "AbuTrika")
        }
    }
    
    func drawSection()->NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading:0, bottom: 0, trailing: 0)
        

        section.orthogonalScrollingBehavior = .continuous
        
        return section
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return viewModel?.getPlayersCount() ?? 0
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as! PlayerCollectionViewCell

        if let player = viewModel?.getPlayerAtIndex(index: indexPath.row) {
            if let playerImageString = player.playerImage, let playerImageURL = URL(string: playerImageString) {
                cell.playerImg.kf.setImage(with: playerImageURL)
            } else {
                cell.playerImg.image = UIImage(named: "AlAhy")
            }
        } else {
            cell.playerImg.image = UIImage(named: "AlAhy")
        }
        
        cell.playerName.text = viewModel?.getPlayerAtIndex(index: indexPath.row).playerName ?? "Un known"

        return cell
    }
    
    
    @IBAction func backBTn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
