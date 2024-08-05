//
//  URLBases.swift
//  MyMoviesD
//
//  Created by Briam Cano on 02/08/24.
//

import Foundation

struct URLBases {
    var tokenAuth = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYzY5NTNhY2EzZjNhNjdhZWNjNzc5Y2I3OGE5NDI0MSIsIm5iZiI6MTcyMjY0MDQwMC44NzQzMDcsInN1YiI6IjYyYjc4OTMwOWQ1OTJjMDA1MTQ4MWQwZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9NYrn3xFOV7yg6moQw74UVLJBQ1SkRR9lUtP6J8iOQk"
    var imageUrlBase = "https://image.tmdb.org/t/p/w500/"
}

enum requestType: String {
    case auth = "https://api.themoviedb.org/3/authentication"
    case upcoming = "https://api.themoviedb.org/3/movie/upcoming"
    case topRated = "https://api.themoviedb.org/3/movie/top_rated"
}

enum methodType: String {
    case get = "GET"
    case post = "POST"
}
