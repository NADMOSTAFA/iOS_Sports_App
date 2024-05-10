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
        print("hi")
    }
    
}

extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let myWidth = UIScreen.main.bounds.size.width - 30
        let myHeight = UIScreen.main.bounds.size.height - 30
        return CGSize(width: myWidth/2, height: myHeight/4)
    }
    
}

