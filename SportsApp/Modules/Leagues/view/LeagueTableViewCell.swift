//
//  LeagueTableViewCell.swift
//  SportsApp
//
//  Created by Nada Mostafa on 11/05/2024.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueLogo: UIImageView!
    static func nib() -> UINib{
        return UINib(nibName: "LeagueTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
