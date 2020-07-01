//
//  FlickrModel.swift
//  DeloietteTest
//
//  Created by Regan Russell on 30/6/20.
//  Copyright © 2020 Regan Russell. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/*
 {
     "id": "39593986652",
     "owner": "36739135@N04",
     "secret": "0ec416669f",
     "server": "4740",
     "farm": 5,
     "title": "IMG_5508",
     "ispublic": 1,
     "isfriend": 0,
     "isfamily": 0
 },
 */

class FlickrModel: Decodable {

    var id : String?
    var owner : String?
    var secret : String?
    var server : String?
    var farm : Int?
    var title : String?
    var ispublic : Int?
    var isfriend : Int?
    var isfamily : Int?
    
    init(id: String, owner: String, secret : String, server: String, farm : Int, title : String, ispublic : Int,  isfriend : Int,  isfamily : Int) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily

    }
    
    class func fromDict(dict:[String:Any?]) -> FlickrModel? {
        let id = dict["id"] as! String
        let owner = dict["owner"] as! String
        let secret = dict["secret"] as! String
        let server = dict["server"] as! String
        let farm = dict["farm"] as! Int
        let title = dict["title"] as! String
        let ispublic = dict["ispublic"] as! Int
        let isfriend = dict["isfriend"] as! Int
        let isfamily = dict["isfamily"] as! Int
        let result: FlickrModel? = FlickrModel(id: id, owner: owner, secret: secret, server: server, farm: farm, title: title, ispublic: ispublic, isfriend: isfriend, isfamily: isfamily)
        
        return result
    }
}
