//
//  ProfilePostsClient.swift
//  fakestagram
//
//  Created by Alan Vargas on 4.05.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class ProfilePostsClient: RestClient<[Post]> {
    convenience init() {
        self.init(client: Client(), path: "/api/profile/posts")
    }
}
