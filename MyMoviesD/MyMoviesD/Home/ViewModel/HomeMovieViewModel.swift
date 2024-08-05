//
//  HomeMovieViewModel.swift
//  MyMoviesD
//
//  Created by Briam Cano on 02/08/24.
//

import Foundation

class HomeMovieViewModel {
    
    var arrayUpcomingData = [UpcomingEntity]()
    var arrayTopRateData = [UpcomingEntity]()
    var serviceManager = ServiceManager()
    
    func getAuth() async throws {
        try await serviceManager.authRequest()
    }
    
    func getUpcomingMovies() async throws -> [UpcomingEntity] {
        
        let data = try await serviceManager.upcomingRequest()
        if let upcomingResponse = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            if let result = upcomingResponse["results"] as? [Any] {
//                print("Esta es la data upcoming: \(result)")
                for movie in result {
                    if let dataMovie = movie as? [String: Any], let title = dataMovie["original_title"] as? String, let imgPath = dataMovie["poster_path"] as? String, let overview = dataMovie["overview"] as? String, let releaseDate = dataMovie["release_date"] as? String {
                        arrayUpcomingData.append(UpcomingEntity(movieName: title, moviewImage: imgPath, movieDescription: overview, date: releaseDate))
                    }
                }
            }
            
        } else {
            debugPrint("Error al parsear...")
        }
        print("Count data array set: \(arrayUpcomingData.count)")
        return arrayUpcomingData
    }
    
    func getTopRatedData(page: String) async throws -> [UpcomingEntity] {
        let data = try await serviceManager.getTopRatedData(page: page)
        if let result =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            
            if let arrayMovies = result["results"] as? [Any] {
                for movie in arrayMovies {
                    if let dataMovie = movie as? [String: Any], let title = dataMovie["original_title"] as? String, let imgPath = dataMovie["poster_path"] as? String, let overview = dataMovie["overview"] as? String, let releaseDate = dataMovie["release_date"] as? String {
                        arrayTopRateData.append(UpcomingEntity(movieName: title, moviewImage: imgPath, movieDescription: overview, date: releaseDate))
                    }
                }
            }
        } else {
            LoadingView().hide()
            print("Error al parseartop rates...")
        }
        print("top Rate: \(arrayTopRateData)")
        return arrayTopRateData
    }
}
