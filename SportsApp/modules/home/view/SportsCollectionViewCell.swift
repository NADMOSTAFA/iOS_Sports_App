//
//  SportsCollectionViewCell.swift
//  SportsApp
//
//  Created by Nada Mostafa on 10/05/2024.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sportImageView: UIImageView!
    
    @IBOutlet weak var sportTitleLabel: UILabel!
    
    func setUp(sport : Sport)  {
        sportImageView.image = UIImage(named: sport.image)
        sportTitleLabel.text = sport.name
    }
}
