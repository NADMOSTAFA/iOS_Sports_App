//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Israa on 11/05/2024.
//

import UIKit
import Kingfisher

class LeagueDetailsViewController: UIViewController {

    @IBOutlet weak var detailsCollectionView: UICollectionView!
    @IBOutlet weak var leagueTitle: UILabel!
    var leaguesViewModel  : LeaguesViewModelProtocol?
    var leagueDetailsViewModel  = LeagueDetailsViewModel(network: NetworkService.instance)

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsCollectionView.dataSource = self
        detailsCollectionView.delegate = self
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
                    switch sectionIndex {
                    case 0 :
                        return self.UpcomingSection()
                    case 1 :
                        return self.LatestResultsSection()
                    default:
                        return self.TeamsSection()
                        
                    }
                }
        self.detailsCollectionView.setCollectionViewLayout(layout, animated: true)
        
        
        leagueDetailsViewModel.loadUpcomingFixture(endPoint: leaguesViewModel!.getEndPoint(), leagueID: (leaguesViewModel?.getselectedLeague().leagueKey)!)
        
        leagueDetailsViewModel.loadLatestResults(endPoint: leaguesViewModel!.getEndPoint(), leagueID: (leaguesViewModel?.getselectedLeague().leagueKey)!)
        
        leagueDetailsViewModel.loadTeams(endPoint: leaguesViewModel!.getEndPoint(), leagueID: (leaguesViewModel?.getselectedLeague().leagueKey)!)
        
        leagueTitle.text = leaguesViewModel?.getselectedLeague().leagueName
        
        leagueDetailsViewModel.bindUpcomingFixtureToViewConreoller = { [weak self] in
            print("Enter")
            DispatchQueue.main.async {
                
                self?.detailsCollectionView.reloadSections(IndexSet(integer: 0))
                self?.detailsCollectionView.reloadData()
            }
        } 
        
        leagueDetailsViewModel.bindLatestResultsToViewConreoller = { [weak self] in
            print("Enter")
            DispatchQueue.main.async {
                self?.detailsCollectionView.reloadSections(IndexSet(integer: 1))
                self?.detailsCollectionView.reloadData()
            }
        }
        
        
        
    }
   
        
        
    
    
    
    func UpcomingSection()-> NSCollectionLayoutSection {
               let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                                     , heightDimension: .fractionalHeight(1))
               let item = NSCollectionLayoutItem(layoutSize: itemSize)
               
               let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                                      , heightDimension: .absolute(200))
               let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
                                                              , subitems: [item])
               group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                             , bottom: 0, trailing: 16)
               
               let section = NSCollectionLayoutSection(group: group)
               section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8
                                                               , bottom: 8, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
               
               //animation
               
               section.visibleItemsInvalidationHandler = { items, offset, environment in
                   items.forEach { item in
                       if item.representedElementCategory == .cell {
                           let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                           let minScale: CGFloat = 0.8
                           let maxScale: CGFloat = 1.0
                           let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                           item.transform = CGAffineTransform(scaleX: scale, y: scale)
                       }
                   }
               }
               return section
           }
           
           func LatestResultsSection()->NSCollectionLayoutSection {
               let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                                     , heightDimension: .fractionalHeight(1))
               let item = NSCollectionLayoutItem(layoutSize: itemSize)
               
               let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                                      , heightDimension: .absolute(100))
               let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                            , subitems: [item])
               group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                             , bottom: 8, trailing: 0)
               
               let section = NSCollectionLayoutSection(group: group)
               section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8
                                                               , bottom: 0, trailing: 8)
               return section
           }
           
           func TeamsSection()-> NSCollectionLayoutSection {
               let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                                     , heightDimension: .fractionalHeight(1))
               let item = NSCollectionLayoutItem(layoutSize: itemSize)
               
               let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45)
                                                      , heightDimension: .absolute(150))
               let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                            , subitems: [item])
               group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                             , bottom: 0, trailing: 15)
               
               let section = NSCollectionLayoutSection(group: group)
               section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
                                                               , bottom: 10, trailing: 0)
               section.orthogonalScrollingBehavior = .continuous
               // Animation
               section.visibleItemsInvalidationHandler = { items, offset, environment in
                   items.forEach { item in
                       if item.representedElementCategory == .cell {
                           let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                           let minScale: CGFloat = 0.8
                           let maxScale: CGFloat = 1.0
                           let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                           item.transform = CGAffineTransform(scaleX: scale, y: scale)
                       }
                   }
               }
               
               return section
           }
           
           
       
       
       
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveLeague(_ sender: Any) {
        
    }
    
}

extension LeagueDetailsViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return leagueDetailsViewModel.getUpcomingFixturesCount()
        case 1:
            return leagueDetailsViewModel.getLatestResultsCount()
        default :
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
              case 0:
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcommingEventCell", for: indexPath) as! UpCommingEventsCollectionViewCell
                 
            if let imageUrl = URL(string: leaguesViewModel?.getEndPoint() == "basketball" ?  self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventHomeTeamLogo ?? "" : self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].homeTeamLogo ?? "") {
                      cell.homeTeamLogo.kf.setImage(with: imageUrl)
                  }  
            if let imageUrl = URL(string: leaguesViewModel?.getEndPoint() == "basketball" ?  self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventAwayTeamLogo ?? "" : self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].awayTeamLogo ?? "") {
                      cell.awayTeamLogo.kf.setImage(with: imageUrl)
                  }
            
            cell.homeTeamName.text = leaguesViewModel?.getEndPoint() == "tennis" ? self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventFirstPlayer ?? " ":
            self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventHomeTeam ?? ""
                  cell.awayTeamName.text = leaguesViewModel?.getEndPoint() == "tennis" ? self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventSecondPlayer ?? " ":
            self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventAwayTeam ?? ""
                
                  cell.eventDate.text = self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventDate
                  cell.eventTime.text = self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventTime
                  return cell
            
            case 1:
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventCell", for: indexPath) as! LatestEventsCollectionViewCell
                 
            if let imageUrl = URL(string: leaguesViewModel?.getEndPoint() == "basketball" ?  self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventHomeTeamLogo ?? "" : self.leagueDetailsViewModel.getLatestResults()[indexPath.row].homeTeamLogo ?? "") {
                      cell.homeTeamLogo.kf.setImage(with: imageUrl)
                  }  
            if let imageUrl = URL(string: leaguesViewModel?.getEndPoint() == "basketball" ?  self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventAwayTeamLogo ?? "" : self.leagueDetailsViewModel.getLatestResults()[indexPath.row].awayTeamLogo ?? "") {
                      cell.awayTeamLogo.kf.setImage(with: imageUrl)
                  }
            
            cell.homeTeamName.text = leaguesViewModel?.getEndPoint() == "tennis" ? self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventFirstPlayer ?? " ":
            self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventHomeTeam ?? ""
                  cell.awayTeamName.text = leaguesViewModel?.getEndPoint() == "tennis" ? self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventSecondPlayer ?? " ":
            self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventAwayTeam ?? ""
                
                  cell.eventDate.text = self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventDate
            if  leaguesViewModel?.getEndPoint() == "/cricket/" {
                cell.eventResult.text = self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventHomeFinalResult
            } else{
                cell.eventResult.text = self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventFinalResult
            }
                    
            return cell
              default:
                  return UICollectionViewCell()
              }
    }
    
    
}

extension LeagueDetailsViewController : UICollectionViewDelegate {
    
}
