//
//  CharacterModel.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 3.04.2023.
//

import Foundation


struct AllCharactersModel: Codable {
    let results: [CharacterModel]
}

struct CharacterModel: Codable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: Species?
    let type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Gender
enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}
// MARK: - Species
enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
    case poopyButtHole = "Poopybutthole"
    case humanoid = "Humanoid"
    case unknown = "unknown"
    case mythologicalCreatur = "Mythological Creature"
    case animal = "Animal"
    case cronenberg = "Cronenberg"
    case robot = "Robot"
}
// MARK: - Status
enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

