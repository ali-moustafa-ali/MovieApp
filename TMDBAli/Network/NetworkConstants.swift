
import Foundation
import Alamofire

class NetworkConstants {
        
    static var baseUrl = "https://api.themoviedb.org/3"
    static var baseImageUrl = "https://image.tmdb.org/t/p/w500"
    static var baseParameters = "cd99f2d3aa1f9678c32316de7e4f2ce1"
    static var languageAr  = "en-US"
    static var languageEn  = "ar-US"
    static var PaginationParameters = "2"
   

    //MARK: - URLS
    struct NetworkEndpoints{
        static let popularMovies = "movie/popular"
        static let upcomingMovies = "movie/upcoming"
        static let nowPlayingMovies = "movie/now_playing"
        static let topRatedMovies = "movie/top_rated"
        static let movieDetails = "movie"
        
        
    }
}
