//
//  CreatePostClient.swift
//  fakestagram
//
//  Created by Alan Vargas on 27.04.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct CreatePostBase64: Codable {
    let title:String
    let imageData:String
    let latitude:Double?
    let longitude:Double?
}

class CreatePostClient {
    private let client = Client()
    private let path = "/api/posts"
    
    let encoder:JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    let decoder:JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func create(title: String, imageData: String, success onSuccess: @escaping (Post) -> Void) {
        let payload = CreatePostBase64(title: title, imageData: imageData, latitude: nil, longitude: nil)
        create(payload: payload, success: onSuccess)
    }
    
    func create( payload:CreatePostBase64, success: @escaping (Post) -> Void ) {
        guard let data = try? encoder.encode(payload) else { return }
        client.request("POST", path: path, body: data, completionHandler: { (response, data) in
            if response.successful(){
                guard let data = data else { print("Empty Data Response"); return }
                do {
                    let json = try self.decoder.decode(Post.self, from: data)
                    success(json)
                } catch let error {
                    print("Error on serialization \(error.localizedDescription)")
                }
            } else {
                print("Error on response: \(response.rawResponse) - \(response.status): \nBody: \(String(describing: data))")
            }
        }, errorHandler: self.onError(error:))
    }
    
    private func onError(error:Error?) -> Void {
        guard let err = error else { return }
        print("Error on request: \(err.localizedDescription)")
    }
    
}
