//
//  ViewController.swift
//  NikeCodeTest
//
//  Created by KIRILL CHUMAK on 12/16/19.
//  Copyright © 2019 Kirill Chumak. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    private var myTableView: UITableView!
    private var dataJSONFile: AlbumData?
    private let top100albumsURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        getDataAndParseJSON()
        myTableView.reloadData()
        
    }
    
    
    private func configureTableView() {
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        myTableView.register(CustomTableCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    
    fileprivate func getImageDataFromURL(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    
    
    
    fileprivate func getDataAndParseJSON() {
        if let url = URL(string: top100albumsURL) {
            do {
                let data = try Data(contentsOf: url)
                self.dataJSONFile = try JSONDecoder().decode(AlbumData.self, from: data)
                
            } catch let error1 {
                print(error1)
            }
        } else {
            print("JSON file doesnt exists")
        }
    }

    
}



extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let numberOfRows = dataJSONFile?.feed.results.count else {return 1}
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! CustomTableCell
        
        cell.albumTitleLabel.text = "\(dataJSONFile?.feed.results[indexPath.row].name ?? "no data")"
        cell.artistNameLabel.text = "\(dataJSONFile?.feed.results[indexPath.row].artistName ?? "no data")"
        
        if let url = URL(string: "\(dataJSONFile?.feed.results[indexPath.row].artworkUrl100 ?? "" )") {
            
            getImageDataFromURL(url: url) { (data, _, error) in
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    cell.productImage.image = image
                }
                if error != nil {
                    print(error!)
                }
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let receivedJSONData = dataJSONFile else {return}
        
        let detailViewController = DetailViewController()
        if let url = URL(string: "\(receivedJSONData.feed.results[indexPath.row].artworkUrl100)") {
            getImageDataFromURL(url: url) { (data, urlResponse, error) in
                guard let myData = data else {return}
                let image = UIImage(data: myData)
                DispatchQueue.main.async {
                    detailViewController.productImage.image = image
                }
                if error != nil {
                    print(error!)
                }
            }
        }
        
        detailViewController.copyrightLabel.text = "\(receivedJSONData.feed.results[indexPath.row].copyright)"
        detailViewController.albumTitleLabel.text = "\(receivedJSONData.feed.results[indexPath.row].name)"
        detailViewController.artistNameLabel.text = "\(receivedJSONData.feed.results[indexPath.row].artistName)"
        detailViewController.genreLabel.text = "\(receivedJSONData.feed.results[indexPath.row].genres[0].name)"
        detailViewController.releaseDateLabel.text = "\(receivedJSONData.feed.results[indexPath.row].releaseDate)"
        detailViewController.itunesURL = "\(receivedJSONData.feed.results[indexPath.row].url)"
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    
}
