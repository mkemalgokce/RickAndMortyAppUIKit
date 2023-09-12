//
//  APICallerManager.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 3.04.2023.
//

import Foundation

enum Constants: String {
    case baseUrl = "https://rickandmortyapi.com/api"
    case characterRoute = "/character"
    case episodeRoute = "/episode"
    case locationRoute = "/location"
    
    static func getFullString(with status: Status) -> String {
        print("\(baseUrl.rawValue + characterRoute.rawValue)?status=\(status.rawValue)")
        return "\(baseUrl.rawValue + characterRoute.rawValue)?status=\(status.rawValue)"
    }
    static func getFullString() -> String {
        return "\(Constants.baseUrl.rawValue + Constants.characterRoute.rawValue)"
    }
    
    static func getFullString(with name: String) -> String {
        return Self.getFullString() + "/?name=\(name)"
    }
}

enum APIManagerError: Error {
    case failedToGetData
    case invalidUrl
    case decodeError
}
class APICallerManager {
    static let shared =  APICallerManager()
    
    private init(){}
    
    func getAllCharacters(_ completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        guard let url = URL(string: Constants.getFullString()) else {
            completion(.failure(APIManagerError.failedToGetData))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, err in
            guard let data = data, err == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(AllCharactersModel.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    func getCharactersWithStatus(_ status: Status, completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        
        guard let url = URL(string: Constants.getFullString(with: status)) else {
            completion(.failure(APIManagerError.invalidUrl))
            return
        }
     
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, err in
            guard let data = data, err == nil else { completion(.failure(APIManagerError.failedToGetData)); return}
            
            do {
                let results = try JSONDecoder().decode(AllCharactersModel.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIManagerError.decodeError))
                print(error)
            }
        }
        task.resume()
        
    }
    
    func getCharacters(with name: String, completion: @escaping(Result<[CharacterModel], Error>) -> Void) {
        guard let url = URL(string: Constants.getFullString(with: name)) else {
            completion(.failure(APIManagerError.invalidUrl))
            return
        }
     
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, err in
            guard let data = data, err == nil else { completion(.failure(APIManagerError.failedToGetData)); return}
            
            do {
                let results = try JSONDecoder().decode(AllCharactersModel.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIManagerError.decodeError))
                print(error)
            }
        }
        task.resume()
        
    }
    
    
    
}

