
import Foundation
import Alamofire

//The AnyObject keyword indicates that this protocol can only be adopted by class types.
protocol RequestHandlerProtocol: AnyObject{
    
    //that takes two parameters
    /*
     params: A dictionary with keys of type String and values of type Any.
     This parameter represents the parameters or data to be sent with the request.
     */
    func getPopularMovies(params: [String : Any],
                          completionHandler: @escaping (AFResult<MoviesModel>) -> ())
    /*
     completionHandler: A closure parameter that takes an AFResult<BroadCastModel> as input and has no return value.
     The closure is marked as @escaping, which means it can be stored and invoked later even after the function has returned.
     The AFResult<BroadCastModel> represents the result of the network request,
     where BroadCastModel is a specific model or data type.
     
     This closure will be called with the result of the network request.
     */
}

//This line declares a class named RequestsHandler that conforms to the RequestHandlerProtocol protocol.
class RequestsHandler: RequestHandlerProtocol {
    /*
     This creates a static property shared of type RequestsHandler.
     It's a common approach to create a shared instance of a class using the singleton pattern.
     */
    static let shared = RequestsHandler()
    /*
     This declares an optional property network of type NetworkConnectionGenericProtocol.
     It represents the network connection object that conforms to the NetworkConnectionGenericProtocol.
     */
    var network: NetworkConnectionGenericProtocol?
    /*
     This is the initializer method for the RequestsHandler class.
     It takes an optional parameter network of type NetworkConnectionGenericProtocol, with a default value of NetworkConnectionGeneric() if no value is provided.
     It initializes the network property with the provided or default network connection object.
     */
    
    init(network: NetworkConnectionGenericProtocol = NetworkConnectionGeneric()) {
        
        self.network = network
    }
    
    /*
     This function is a part of the RequestsHandler class and implements the method getBroadcastsRequest defined in the RequestHandlerProtocol.
     */
    func getPopularMovies(params: [String : Any],
                          completionHandler: @escaping (AFResult<MoviesModel>) -> ()){
        
        print(params, "getPopularMovies")
        /*
         it calls the performGet method on the network object,
         passing the appropriate URLRequestConvertible object (Routers.defaultBroadcast(para: params)) and the expected response type (DefaultBroadcastModel.self).
         Finally, it calls the completionHandler with the response received from the network request.
         */
        network?.performGet(Routers.getPopularMovies(para: params),
                            MoviesModel.self){
            response in
            completionHandler(response)
        }
    }
    
    
    func getMovieDetails(params: [String : Any],
                         completionHandler: @escaping (AFResult<MovieDetails>) -> ()){
        
        print(params, "getMovieDetails")
        /*
         it calls the performGet method on the network object,
         passing the appropriate URLRequestConvertible object (Routers.defaultBroadcast(para: params)) and the expected response type (DefaultBroadcastModel.self).
         Finally, it calls the completionHandler with the response received from the network request.
         */
        network?.performGet(Routers.getMovieDetails(para: params),
                            MovieDetails.self){
            response in
            completionHandler(response)
        }
    }
    
    
    func getNowPlayingMovies(params: [String : Any],
                             completionHandler: @escaping (AFResult<MoviesModel>) -> ()){
        
        print(params, "getPopularMovies")
        /*
         it calls the performGet method on the network object,
         passing the appropriate URLRequestConvertible object (Routers.defaultBroadcast(para: params)) and the expected response type (DefaultBroadcastModel.self).
         Finally, it calls the completionHandler with the response received from the network request.
         */
        network?.performGet(Routers.getNowPlayingMovies(para: params),
                            MoviesModel.self){
            response in
            completionHandler(response)
        }
    }
    
    func getUpcomingMovies(params: [String : Any],
                           completionHandler: @escaping (AFResult<MoviesModel>) -> ()){
        
        print(params, "getPopularMovies")
        /*
         it calls the performGet method on the network object,
         passing the appropriate URLRequestConvertible object (Routers.defaultBroadcast(para: params)) and the expected response type (DefaultBroadcastModel.self).
         Finally, it calls the completionHandler with the response received from the network request.
         */
        network?.performGet(Routers.getUpcomingMovies(para: params),
                            MoviesModel.self){
            response in
            completionHandler(response)
        }
    }
    
    func getTopRatedMovies(params: [String : Any],
                           completionHandler: @escaping (AFResult<MoviesModel>) -> ()){
        
        print(params, "getPopularMovies")
        /*
         it calls the performGet method on the network object,
         passing the appropriate URLRequestConvertible object (Routers.defaultBroadcast(para: params)) and the expected response type (DefaultBroadcastModel.self).
         Finally, it calls the completionHandler with the response received from the network request.
         */
        network?.performGet(Routers.getTopRatedMovies(para: params),
                            MoviesModel.self){
            response in
            completionHandler(response)
        }
    }
    
}
/*
 In summary, the RequestsHandler class provides an implementation for the getBroadcastsRequest method defined in the RequestHandlerProtocol.
 It uses a network connection object (NetworkConnectionGenericProtocol) to perform a GET request to retrieve default broadcast data and passes the result to the completion handler.
 */
