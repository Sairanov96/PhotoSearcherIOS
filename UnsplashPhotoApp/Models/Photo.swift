//
//  Photo.swift
//  UnsplashPhotoApp
//
//  Created by Amir on 30.04.2022.
//

import Foundation

struct Photo: Codable {
    let id: String
    let created_at: String
    let urls: Urls
    let user: User
    let downloads: Int
}

struct User: Codable {
    let name: String?
    let location: String?
}

struct Urls: Codable {
    let small: String
    let thumb: String
}
