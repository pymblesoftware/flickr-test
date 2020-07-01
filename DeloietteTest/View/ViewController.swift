//
//  ViewController.swift
//  DeloietteTest
//
//  Created by Regan Russell on 30/6/20.
//  Copyright © 2020 Regan Russell. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
    
    var posts: [FlickrModel] = []
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
            
        tblView.dataSource = self
        tblView.delegate = self
        
        let client = ApiClient.shared
           do{
             try client.getPhotoList().subscribe(
               onNext: { result in
                  self.posts = result
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
                print(" done")
             },
               onError: { error in
                  print(error.localizedDescription)
               },
               onCompleted: {
                  print("Completed event.")
               }).disposed(by: disposeBag)
             }
             catch{
                
           }
     }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as? PhotoTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PhotoTableViewCell.")
        }

        let item = self.posts[indexPath.row]
        cell.title.text = item.title
        // http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg

        let url = "http://farm\(item.farm ?? 0).static.flickr.com/\(item.server ?? "")/\(item.id ?? "")_\(item.secret ?? "").jpg"
        
        cell.imgView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))

           return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

}




