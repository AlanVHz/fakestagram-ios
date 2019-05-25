//
//  Like.swift
//  fakestagram
//
//  Created by Alan Vargas on 26.04.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct Like: Codable {
    let author: Author?
    let createdAt: String
    let updatedAt: String
}
