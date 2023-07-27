
import Foundation
import Alamofire

enum Routers: URLRequestConvertible {
    
    case getPopularMovies(para: [String: Any])
    case getTopRatedMovies(para: [String: Any])
    case getUpcomingMovies(para: [String: Any])
    case getNowPlayingMovies(para: [String: Any])
    case getMovieDetails(para: [String: Any])
    
    
    var url: URL{
        
        switch self {
            
        case .getPopularMovies:
            var endpoint = NetworkConstants.NetworkEndpoints.popularMovies
            return URL(string: NetworkConstants.baseUrl)!.appendingPathComponent(endpoint)
        case .getTopRatedMovies:
            var endpoint = NetworkConstants.NetworkEndpoints.topRatedMovies
            return URL(string: NetworkConstants.baseUrl)!.appendingPathComponent(endpoint)
        case .getUpcomingMovies:
            var endpoint = NetworkConstants.NetworkEndpoints.upcomingMovies
            return URL(string: NetworkConstants.baseUrl)!.appendingPathComponent(endpoint)
        case .getNowPlayingMovies:
            var endpoint = NetworkConstants.NetworkEndpoints.nowPlayingMovies
            return URL(string: NetworkConstants.baseUrl)!.appendingPathComponent(endpoint)
            
            
            
            
        case .getMovieDetails(para: let para):
            let id = para["id"] as! String
            var endpoint = NetworkConstants.NetworkEndpoints.movieDetails
            return URL(string: NetworkConstants.baseUrl)!.appendingPathComponent(endpoint).appendingPathComponent(id)
            
        }
    }
        
        var method: HTTPMethod{
            switch self {
                
            default:
                return .get
            }
        }
        
        var parameters: [String : Any]?{
            switch self {
            case .getPopularMovies(para: let para):
                return para
            case .getNowPlayingMovies(para: let para):
                return para
            case .getTopRatedMovies(para: let para):
                return para
            case .getUpcomingMovies(para: let para):
                return para
                
            case .getMovieDetails(para: let para):
                if let apiKey: String = para["api_key"] as? String, let language = para["language"] as? String{
                    return ["api_key" : apiKey, "language" : language]
                    
                }else {
                    return nil
                }
                
                
            }
            
        }
        
        var encoding: ParameterEncoding{
            switch self{
                
            default:
                return URLEncoding.default
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            return try encoding.encode(request, with: parameters)
        }
    }
    

