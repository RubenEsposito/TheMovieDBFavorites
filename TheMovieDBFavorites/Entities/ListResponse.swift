//
//  ListResponse.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

// MARK: - ListResponse
struct ListResponse: Codable {
    let page: Int?
    let results: [ListResult]?
    let total_pages, total_results: Int?
}

// MARK: - ListResult
struct ListResult: Codable{
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids: [Int]?
    let id: Int?
    let original_language: String?
    let original_title, overview: String?
    let popularity: Double?
    let poster_path, release_date, title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}
