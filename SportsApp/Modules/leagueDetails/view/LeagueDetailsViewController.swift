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
    var teamList : [Int:Team]?

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsCollectionView.dataSource = self
        detailsCollectionView.delegate = self
        teamList = [:]

        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in
                    switch sectionIndex {
                    case 0 :
                        return self.UpcomingSection()
                    case 1 :
                        return self.LatestResultsSection()
                    case 2 :
                        return self.TeamsSection()

                    default:
                        return self.TeamsSection()
                        
                    }
                }
        self.detailsCollectionView.setCollectionViewLayout(layout, animated: true)
        
        
        leagueDetailsViewModel.loadUpcomingFixture(endPoint: leaguesViewModel!.getselectedLeague().sportType!, leagueID: (leaguesViewModel?.getselectedLeague().leagueKey)!)
        
        leagueDetailsViewModel.loadLatestResults(endPoint: leaguesViewModel!.getselectedLeague().sportType!, leagueID: (leaguesViewModel?.getselectedLeague().leagueKey)!)
        

        
        leagueTitle.text = leaguesViewModel?.getselectedLeague().leagueName
        
        leagueDetailsViewModel.bindUpcomingFixtureToViewConreoller = { [weak self] in
            print("Enter")
            DispatchQueue.main.async {
                self?.getTeams()
                self?.detailsCollectionView.reloadData()
                
            }
        } 
        
        leagueDetailsViewModel.bindLatestResultsToViewConreoller = { [weak self] in
            print("Enter")
            DispatchQueue.main.async {
                self?.getTeams()
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
        section.orthogonalScrollingBehavior = .paging
               
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
                                                            , bottom: 8, trailing: 8)
    
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
    
    func getTeams() {
        let upcomingFixtures = leagueDetailsViewModel.getUpcomingFixtures()
        print(upcomingFixtures.count)
        let latestResults = leagueDetailsViewModel.getLatestResults()
        print(latestResults.count)

        if upcomingFixtures.isEmpty &&  latestResults.isEmpty {
            return
        }

        
        for fixture in upcomingFixtures {
            print(fixture.home_team_key)
            print(fixture.away_team_key)
            
            if let homeTeamKey = leaguesViewModel?.getselectedLeague().sportType == "tennis" ? fixture.first_player_key : fixture.home_team_key,
               let awayTeamKey = leaguesViewModel?.getselectedLeague().sportType == "tennis" ? fixture.second_player_key : fixture.away_team_key {
                
                print("enter in if con")

                if teamList?[homeTeamKey] == nil {
                    teamList?[homeTeamKey] = Team(teamKey: homeTeamKey, teamName: fixture.eventHomeTeam, teamLogo: fixture.homeTeamLogo)
                }
                
                if teamList?[awayTeamKey] == nil {
                    teamList?[awayTeamKey] = Team(teamKey: awayTeamKey, teamName: fixture.eventAwayTeam, teamLogo: fixture.awayTeamLogo)
                }
            }
        }
        
        for result in latestResults {
            if let homeTeamKey = leaguesViewModel?.getselectedLeague().sportType == "tennis" ? result.first_player_key : result.home_team_key,
               let awayTeamKey = leaguesViewModel?.getselectedLeague().sportType == "tennis" ? result.second_player_key : result.away_team_key {
                if teamList?[homeTeamKey] == nil {
                    teamList?[homeTeamKey] = Team(teamKey: homeTeamKey, teamName: result.eventHomeTeam, teamLogo: result.homeTeamLogo)
                }
                
                if teamList?[awayTeamKey] == nil {
                    teamList?[awayTeamKey] = Team(teamKey: awayTeamKey, teamName: result.eventAwayTeam, teamLogo: result.awayTeamLogo)
                }
            }
        }
        
        print (teamList?.count ?? 8)
        
    }

    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveLeague(_ sender: Any) {
        leagueDetailsViewModel.saveLeague(savedLeague: (leaguesViewModel?.getselectedLeague())!)
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
        case 2 :
            return teamList?.count ?? 0
        default :
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
              case 0:
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcommingEventCell", for: indexPath) as! UpCommingEventsCollectionViewCell
                 
            if let imageUrl = URL(string: leaguesViewModel?.getselectedLeague().sportType == "basketball" ?  self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventHomeTeamLogo ?? "" : self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].homeTeamLogo ?? "") {
                      cell.homeTeamLogo.kf.setImage(with: imageUrl)
                  }  
            if let imageUrl = URL(string: leaguesViewModel?.getselectedLeague().sportType == "basketball" ?  self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventAwayTeamLogo ?? "" : self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].awayTeamLogo ?? "") {
                      cell.awayTeamLogo.kf.setImage(with: imageUrl)
                  }
            
            cell.homeTeamName.text = leaguesViewModel?.getselectedLeague().sportType == "tennis" ? self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventFirstPlayer ?? " ":
            self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventHomeTeam ?? ""
                  cell.awayTeamName.text = leaguesViewModel?.getselectedLeague().sportType == "tennis" ? self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventSecondPlayer ?? " ":
            self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventAwayTeam ?? ""
                
                  cell.eventDate.text = self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventDate
                  cell.eventTime.text = self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].eventTime
                cell.leagueName.text = self.leagueDetailsViewModel.getUpcomingFixtures()[indexPath.row].leagueRound
                  return cell
            
            case 1:
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventCell", for: indexPath) as! LatestEventsCollectionViewCell
                 
            if let imageUrl = URL(string: leaguesViewModel?.getselectedLeague().sportType == "basketball" ?  self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventHomeTeamLogo ?? "" : self.leagueDetailsViewModel.getLatestResults()[indexPath.row].homeTeamLogo ?? "") {
                      cell.homeTeamLogo.kf.setImage(with: imageUrl)
                  }  
            if let imageUrl = URL(string: leaguesViewModel?.getselectedLeague().sportType == "basketball" ?  self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventAwayTeamLogo ?? "" : self.leagueDetailsViewModel.getLatestResults()[indexPath.row].awayTeamLogo ?? "") {
                      cell.awayTeamLogo.kf.setImage(with: imageUrl)
                  }
            
            cell.homeTeamName.text = leaguesViewModel?.getselectedLeague().sportType == "tennis" ? self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventFirstPlayer ?? " ":
            self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventHomeTeam ?? ""
                  cell.awayTeamName.text = leaguesViewModel?.getselectedLeague().sportType == "tennis" ? self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventSecondPlayer ?? " ":
            self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventAwayTeam ?? ""
                
                  cell.eventDate.text = self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventDate
            if  leaguesViewModel?.getselectedLeague().sportType! == "/cricket/" {
                cell.eventResult.text = self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventHomeFinalResult
            } else{
                cell.eventResult.text = self.leagueDetailsViewModel.getLatestResults()[indexPath.row].eventFinalResult
            }
                    
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell
            let index = Array(teamList!.keys)[indexPath.row]
            cell.teamName.text = teamList?[index]?.teamName
            if let imageUrl = URL(string: teamList?[index]?.teamLogo ?? ""){
                         cell.teamLogo.kf.setImage(with:imageUrl)
                     }
                     else{
                         cell.teamLogo.image = UIImage(named: "AlAhy")
                     }
            return cell
              default:
                  return UICollectionViewCell()
              }
    }
    
    
}

extension LeagueDetailsViewController : UICollectionViewDelegate {
    
}
