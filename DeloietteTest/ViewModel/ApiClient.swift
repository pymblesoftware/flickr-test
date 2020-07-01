//
//  ApiClient.swift
//  DeloietteTest
//
//  Created by Regan Russell on 30/6/20.
//  Copyright © 2020 Regan Russell. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


fileprivate extension Encodable {
  var dictionaryValue:[String: Any?]? {
      guard let data = try? JSONEncoder().encode(self),
      let dictionary = try? JSONSerialization.jsonObject(with: data,
        options: .allowFragments) as? [String: Any] else {
      return nil
    }
    return dictionary
  }
}
// https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=96358825614a5d3b1a1c3fd87fca2b47&text=kittens&format=json&nojsoncallback=1

class ApiClient: NSObject {

    static var shared = ApiClient()
    lazy var requestObservable = RequestObservable(config: .default)
    func getPhotoList() throws -> Observable<[FlickrModel]> {
        
      var request = URLRequest(url:
            URL(string:"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=96358825614a5d3b1a1c3fd87fca2b47&text=kittens&format=json&nojsoncallback=1")!)
      request.httpMethod = "GET"
      request.addValue("application/json", forHTTPHeaderField:
                "Content-Type")
      return requestObservable.callAPI(request: request)
    }
    
}
