//
//  Section.swift
//  SportsApp
//
//  Created by Israa on 15/05/2024.
//

import UIKit
class SectionHeaderView : UICollectionReusableView {
    
    let sectionTitle: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(sectionTitle)
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            sectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            sectionTitle.topAnchor.constraint(equalTo: topAnchor),
            sectionTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String) {
        sectionTitle.text = title
    }
}
