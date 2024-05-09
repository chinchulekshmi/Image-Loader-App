//
//  ImageModel.swift
//  ImageLoaderApp
//
//  Created by Toqsoft on 06/05/24.
//

import Foundation
 struct ImageModel: Codable {
    let id: String
    let title: String
    let publishedBy : String
    let publishedAt: String
    let thumbnail: Thumbnail
 }

 struct Thumbnail: Codable {
    let domain: String
    let basePath: String
    let key: String
 }
