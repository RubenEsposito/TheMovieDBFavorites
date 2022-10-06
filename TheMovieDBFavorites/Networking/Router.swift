//
//  Router.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let apiKey = "5390cd233442a8c5755bf9585b1a46cc"
    
    case listPopularMovies
    case search(query: String?)
    case movieDetail(movieID: Int?)
    
    var baseURL : URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .listPopularMovies, .search, .movieDetail:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        var params: Parameters = [:]
        switch self {
        case .listPopularMovies:
            return nil
        case .search(query: let query):
            if let query = query {
                params["query"] = query
            }
        case .movieDetail(movieID: let movieID):
            if let movieID = movieID {
                params["movieID"] = movieID
            }
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var path: String {
        switch self {
        case .listPopularMovies:
            return "/movie/popular"
        case .search:
            return "search/movie"
        case .movieDetail(movieID: let movieID):
            if let movieID = movieID {
                return "movie/\(movieID)"
            }
        }
        return ""
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        var completeParameters = parameters ?? [:]
        
        completeParameters["api_key"] = Router.apiKey
        
        let urlRequestPrint = try encoding.encode(urlRequest, with: completeParameters)
        debugPrint("✅ Requested URL: ", urlRequestPrint.url ?? "")
        
        return try encoding.encode(urlRequest, with: completeParameters)
    }
    
}
