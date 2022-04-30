//
//  PhotoManager.swift
//  UnsplashPhotoApp
//
//  Created by Amir on 29.04.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
enum Keys {
    static let privateKey  = "1zwt0v33E8CS9zDdfP6MYCIkhYrnkxHIfoeMcoMShG4"
}
enum URLS {
    static let randomPhoto = "https://api.unsplash.com/photos/random?&client_id=\(Keys.privateKey)"
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRandomPhoto(completion: @escaping(Result<Photo, NetworkError>) -> Void) {
        guard let url = URL(string: URLS.randomPhoto) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let photo = try JSONDecoder().decode(Photo.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(photo))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void){
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
}
