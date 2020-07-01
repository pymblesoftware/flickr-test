//
//  RequestObservable.swift
//  DeloietteTest
//
//  Created by Regan Russell on 30/6/20.
//  Copyright © 2020 Regan Russell. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RequestObservable: NSObject {
    private lazy var jsonDecoder = JSONDecoder()
      private var urlSession: URLSession
      public init(config:URLSessionConfiguration) {
          urlSession = URLSession(configuration:
                    URLSessionConfiguration.default)
      }
      // function for URLSession takes
      public func callAPI<ItemModel: Decodable>(request: URLRequest)
        -> Observable<ItemModel> {
      // creating  observable
      return Observable.create { observer in
      // create URLSession dataTask
      let task = self.urlSession.dataTask(with: request) { (data,
                    response, error) in
      if let httpResponse = response as? HTTPURLResponse{
      let statusCode = httpResponse.statusCode
      do {
        var result = [FlickrModel]()
        let _data = data ?? Data()
        if (200...399).contains(statusCode) {
        let utf8Data = String(decoding: _data, as: UTF8.self).data(using: .utf8)
            if let dict  = try JSONSerialization.jsonObject(with: utf8Data!, options: .allowFragments ) as? [String:Any] {
                    if dict["photos"] != nil {
                        let photos = dict["photos"] as! [String:Any]
                        let arr = photos["photo"] as! [Any]
                        for curr in arr {
                            let dict = curr as! [String : Any?]
                            result.append(FlickrModel.fromDict(dict: dict)!)
                        }
                    }
                observer.onNext(result as! ItemModel)
                }
        }
        else {
          observer.onError(error!)
        }
      } catch {
          // observer onNext event
          observer.onError(error)
         }
       }
         // observer onCompleted event
         observer.onCompleted()
       }
         task.resume()
         // return our disposable
         return Disposables.create {
           task.cancel()
         }
       }
      }
}
