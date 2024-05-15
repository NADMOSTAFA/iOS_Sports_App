//
//  ViewController.swift
//  SportsApp
//
//  Created by Nada Mostafa on 10/05/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let homeViewModel : HomeViewModelProtocol = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let view = self.navigationController!.visibleViewController;
        view!.navigationItem.title = "All Sports"
    }
}



extension ViewController : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.getSportsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportsCollectionViewCell
        cell.setUp(sport: homeViewModel.getSports()[indexPath.row])
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 25
        cell.sportImageView.layer.cornerRadius = 25
        
        return cell
    }
    
    
   
}

extension ViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if NetworkAvailibility.isConnected(){
            let leagues = self.storyboard?.instantiateViewController(identifier: "leagues") as! LeaguesViewController
            switch indexPath.row {
            case 0:
                homeViewModel.setSportType(type: EndPoints.football.rawValue)
            case 1:
                homeViewModel.setSportType(type: EndPoints.basketball.rawValue)
            case 2:
                homeViewModel.setSportType(type: EndPoints.tennis.rawValue)
            case 3:
                homeViewModel.setSportType(type: EndPoints.cricket.rawValue)
            default:
                homeViewModel.setSportType(type: "")
            }
            leagues.homeViewModel = self.homeViewModel
            self.navigationController?.pushViewController(leagues, animated: true)
        }else{
            let alertController = UIAlertController(title: "Error!", message: "No Internet Connection", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let myWidth = UIScreen.main.bounds.size.width - 30
        let myHeight = UIScreen.main.bounds.size.height - 30
        return CGSize(width: myWidth/2, height: myHeight/4)
    }
    
}

