//
//  DetailViewController.swift
//  NikeCodeTest
//
//  Created by KIRILL CHUMAK on 12/16/19.
//  Copyright © 2019 Kirill Chumak. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: Properties
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.distribution = .fill
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
    
    let copyrightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 10)
        label.textColor = .black
        return label
    }()
    
    
    let albumTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .italicSystemFont(ofSize: 13)
        label.textColor = .darkGray
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()
    
    let openLinkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("Open in Safari", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    var itunesURL = ""
    
    // MARK: View controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        configureUserInterface()
    }
    
    fileprivate func configureUserInterface() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        stackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(productImage)
        verticalStackView.addArrangedSubview(copyrightLabel)
        productImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        copyrightLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        stackView.addArrangedSubview(albumTitleLabel)
        stackView.addArrangedSubview(artistNameLabel)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        view.addSubview(openLinkButton)
        openLinkButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        openLinkButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        openLinkButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    fileprivate func setUpNavBar(){
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    
    //MARK: Actions
    @objc func buttonAction(sender: UIButton!) {
        if let url = URL(string: itunesURL) {
            UIApplication.shared.open(url)
        }
    }
    
    
}
