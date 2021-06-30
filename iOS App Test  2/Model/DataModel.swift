//
//  UserModel.swift
//  iOS App Test  2
//
//  Created by Himanshu Khare on 30/06/21.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct WeatherModel: Codable {
    
    let weather: [Weather]
    let main: Main
    let name: String
    
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feels_like, temp_min, temp_max: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feels_like
        case temp_min
        case temp_max
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let message: Double
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case description
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct PincodeModel: Codable {
    let Message, Status: String
    let PostOffice: [PostOffice]?
    
    enum CodingKeys: String, CodingKey {
        case Message
        case Status
        case PostOffice
    }
}

// MARK: - PostOffice
struct PostOffice: Codable {
    let State, District: String
    enum CodingKeys: String, CodingKey {
        case District
        case State
    }
}
