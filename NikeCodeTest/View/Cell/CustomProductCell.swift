//
//  CustomProductCell.swift
//  NikeCodeTest
//
//  Created by KIRILL CHUMAK on 12/16/19.
//  Copyright © 2019 Kirill Chumak. All rights reserved.
//


import UIKit

class CustomTableCell: UITableViewCell {
    
    
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    let productImage : UIImageView = {
        let image = UIImage(named: "image")
        let imgView = UIImageView(image: image)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    let albumTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = .italicSystemFont(ofSize: 13)
        label.textColor = .darkGray
        return label
    }()
    
    
    fileprivate func tableViewCellUserInterface() {
        
        contentView.backgroundColor = .white 
        
        addSubview(horizontalStackView)
        horizontalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        horizontalStackView.addArrangedSubview(productImage)
        horizontalStackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(albumTitleLabel)
        verticalStackView.addArrangedSubview(artistNameLabel)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.tableViewCellUserInterface()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


