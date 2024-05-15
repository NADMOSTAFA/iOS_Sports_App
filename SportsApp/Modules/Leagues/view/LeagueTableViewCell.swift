//
//  LeagueTableViewCell.swift
//  SportsApp
//
//  Created by Nada Mostafa on 11/05/2024.
//

import UIKit
import Kingfisher

class LeagueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueLogo: UIImageView!
    static func nib() -> UINib{
        return UINib(nibName: "LeagueTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print("1")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none

        // Configure the view for the selected state
    }
    
    func setUp(league : League){
        leagueLogo.contentMode = .scaleAspectFill // Adjust content mode according to your
        leagueLogo.clipsToBounds = true
        leagueLogo.layer.cornerRadius = leagueLogo.frame.size.width/2
        leagueLogo.layer.borderWidth = 1.0
        leagueLogo.layer.borderColor = UIColor.black.cgColor
        leagueName.text = league.leagueName
       let processor = DownsamplingImageProcessor(size: leagueLogo.bounds.size)
                    |> RoundCornerImageProcessor(cornerRadius: 20)
       leagueLogo.kf.indicatorType = .activity
       guard let url = league.leagueLogo else{
           leagueLogo.image = getImagePlaceHolder(sportType: league.sportType!)
           return
       }
//           cell.leagueLogo.kf.setImage(with: URL(string: url))
      leagueLogo.kf.setImage(
           with: URL(string: url),
           placeholder: getImagePlaceHolder(sportType: league.sportType!),
           options: [
               .processor(processor),
               .scaleFactor(UIScreen.main.scale),
               .transition(.fade(1)),
               .cacheOriginalImage
           ],completionHandler: nil)
    }
    
    func getImagePlaceHolder(sportType: String)->UIImage{
        switch sportType{
            case EndPoints.football.rawValue:
                return UIImage(named: "fotball1")!
            case EndPoints.tennis.rawValue:
                return UIImage(named: "tennis2")!
            case EndPoints.basketball.rawValue:
                return UIImage(named: "basket2")!
            case EndPoints.cricket.rawValue:
                return UIImage(named: "cricket2")!
            default: return UIImage()
            
        }
    }
}
