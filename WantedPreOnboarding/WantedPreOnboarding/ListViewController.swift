//
//  ListViewController.swift
//  WantedPreOnboarding
//
//  Created by 이학진 on 2023/03/01.
//

import UIKit

class ListViewController: UITableViewController {
    
    @IBOutlet var tableview_custom: UITableView!
    
    let urlList: [String] = Array(repeating: "https://picsum.photos/200/300", count: 5)
    
    lazy var imageList: [ImageVO] = urlList.map {
        ImageVO(url: $0)
    }
    
    override func viewDidLoad() {
        tableview_custom.delegate = self
        tableview_custom.dataSource = self
    }
    
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imagecellIdentifier", for: indexPath) as! ImageCell
        
        cell.randomImage.image = UIImage(systemName: "photo")
        cell.loadingBtn.tag = indexPath.row
        cell.loadingBtn.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        return cell
    }
    
    @objc func loadImage(sender: UIButton) {
        let index = sender.tag
        let path = IndexPath(row: index, section: 0)
        let customCell = tableview_custom.cellForRow(at: path) as! ImageCell
        let row: ImageVO = imageList[index]
        let url = URL(string: row.url)!
        
        customCell.randomImage.image = UIImage(systemName: "photo")
        customCell.randomImage.load(url: url)
    }
    
    @IBAction func loadAllImages(_ sender: Any) {
        let indexList = urlList.indices
        var indexPaths: [IndexPath] = []
        
        for index in indexList {
            let indexPath = IndexPath(row: index, section: 0)
            indexPaths.append(indexPath)
        }
        
        for path in indexPaths {
            let customCell = tableview_custom.cellForRow(at: path) as! ImageCell
            customCell.randomImage.image = UIImage(systemName: "photo")
            let row: ImageVO = imageList[path.row]
            let url = URL(string: row.url)!
            
            customCell.randomImage.load(url: url)
        }
    }
}

