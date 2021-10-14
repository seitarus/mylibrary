//
//  ImagesResponse.swift
//  Biblioteca
//
//  Created by Alejandro Prieto Beltrán on 19/01/2021.
//  Copyright © 2021 Razeware. All rights reserved.
//
//   let imagesResponse = try? newJSONDecoder().decode(ImagesResponse.self, from: jsonData)

import Foundation

// MARK: - ImagesResponse
struct ImagesResponse: Codable {
    let requestInfo: RequestInfo
    let searchMetadata: SearchMetadata
    let searchParameters: SearchParameters
    let searchInformation: SearchInformation
    let topCarousel: TopCarousel
    let imageResults: [ImageResult]

    enum CodingKeys: String, CodingKey {
        case requestInfo = "request_info"
        case searchMetadata = "search_metadata"
        case searchParameters = "search_parameters"
        case searchInformation = "search_information"
        case topCarousel = "top_carousel"
        case imageResults = "image_results"
    }
}

// MARK: - ImageResult
struct ImageResult: Codable {
    let position: Int
    let title: String
    let link: String
    let domain: String
    let width, height: Int
    let image: String
    let imageResultDescription: String?
    let brand: String?

    enum CodingKeys: String, CodingKey {
        case position, title, link, domain, width, height, image
        case imageResultDescription = "description"
        case brand
    }
}

// MARK: - RequestInfo
struct RequestInfo: Codable {
    let success: Bool
    let creditsUsed, creditsRemaining, creditsUsedThisRequest: Int

    enum CodingKeys: String, CodingKey {
        case success
        case creditsUsed = "credits_used"
        case creditsRemaining = "credits_remaining"
        case creditsUsedThisRequest = "credits_used_this_request"
    }
}

// MARK: - SearchInformation
struct SearchInformation: Codable {
    let originalQueryYieldsZeroResults: Bool
    let queryDisplayed: String

    enum CodingKeys: String, CodingKey {
        case originalQueryYieldsZeroResults = "original_query_yields_zero_results"
        case queryDisplayed = "query_displayed"
    }
}

// MARK: - SearchMetadata
struct SearchMetadata: Codable {
    let createdAt, processedAt: String
    let totalTimeTaken: Double
    let engineURL, htmlURL, jsonURL: String
    let timing: [String]?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case processedAt = "processed_at"
        case totalTimeTaken = "total_time_taken"
        case engineURL = "engine_url"
        case htmlURL = "html_url"
        case jsonURL = "json_url"
        case timing
    }
}

// MARK: - SearchParameters
struct SearchParameters: Codable {
    let q, searchType, engine: String

    enum CodingKeys: String, CodingKey {
        case q
        case searchType = "search_type"
        case engine
    }
}

// MARK: - TopCarousel
struct TopCarousel: Codable {
    let items: [ItemCarousel]
}

// MARK: - Item
struct ItemCarousel: Codable {
    let title: String
    let link: String
    let blockPosition: Int

    enum CodingKeys: String, CodingKey {
        case title, link
        case blockPosition = "block_position"
    }
}
