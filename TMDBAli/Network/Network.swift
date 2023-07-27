
/*
 network connection implementation using Alamofire, SwiftyJSON, and Foundation frameworks.
 */
import Foundation
import Alamofire
import SwiftyJSON

/*
 It consists of two main parts:
 the NetworkConnectionGenericProtocol protocol
 and the NetworkConnectionGeneric class.
 */

typealias NetworkCompletion<T> = (AFResult<T>) -> Void

/*
 NetworkConnectionGenericProtocol:

 This protocol defines two methods:
 performGet(_:type:completionHandler:)
 and performPost(_:type:completionHandler:).
 These methods are used to perform GET and POST requests respectively.
 The methods are generic, where T represents the expected response type,
 which must conform to the Codable protocol.
 The completionHandler parameter is a closure of type NetworkCompletion<T>,
 which takes an AFResult<T> as input and has no return value.
 It represents the completion handler that will be invoked with the result of the network request.

 */

protocol NetworkConnectionGenericProtocol: AnyObject {
    
    func performGet<T:Codable>(_ request: URLRequestConvertible,
                               _ type: T.Type,
                               completionHandler: @escaping NetworkCompletion<T>)
    
    func performPost<T:Codable>(_ request: URLRequestConvertible,
                                _ type: T.Type,
                                completionHandler: @escaping NetworkCompletion<T>)
}


/*
 NetworkConnectionGeneric class:
 This class implements the NetworkConnectionGenericProtocol protocol.
 */

class NetworkConnectionGeneric: NetworkConnectionGenericProtocol{
// It has a private property networkMiddleware of type NetworkMiddleware, which is responsible for managing the network operations.

    private let networkMiddleware = NetworkMiddleware()
    
//    The manager property is a lazy property of type Session from Alamofire.
//    Use a network middleware to append the headers globally
    private lazy var manager: Session = {
//        It is initialized using the networkMiddleware.sessionManager property, which is responsible for making the actual network requests.

        let manager = networkMiddleware.sessionManager
    //        manager.adapter = networkMiddleware
        return manager
    }()
    
    /*
     The performGet method takes a URLRequestConvertible object, the expected response type T, and a completion handler closure. It prints the request headers and the session headers, then uses the manager to make a GET request with the provided request object. It also calls the process method to handle the response and invokes the completion handler with the processed result.
     */
    
    func performGet<T:Codable>(_ request: URLRequestConvertible,
                               _ type: T.Type,
                               completionHandler: @escaping NetworkCompletion<T>){
        print(request.urlRequest?.headers, "request headers")
        do {
        try    print(request.asURLRequest(), "url request")

        } catch {
            
        }
        
        print(manager.sessionConfiguration.headers.dictionary, "session headers")

        manager.request(request).responseDecodable(of: type){
            response in
            print("response model", response.response)
            
            completionHandler(self.process(response: response,
                                           decodedTo: type))
        }
    }
    
//    The performPost method is similar to performGet but is used for making POST requests.


    func performPost<T:Codable>(_ request: URLRequestConvertible,
                                _ type: T.Type,
                                completionHandler: @escaping NetworkCompletion<T>){
        
        print(request.urlRequest?.headers, "request headers")

        print(request.urlRequest?.method, "request iii")
        
        manager.request(request).responseDecodable(of: type){
            response in
            
            print("response model", response.response)
            
            completionHandler(self.process(response: response,
                                           decodedTo: type))
        }
    }
    /*
     The process method takes a DataResponse<T, AFError> object and the expected response type T.
     
     It handles the response result (success or failure) and processes the data using JSON decoding.
     
     If the response is successful and the data can be decoded successfully, it returns an .success case of AFResult<T> with the decoded data.
     If there is an error during decoding or if the response is a failure, it returns an appropriate .failure case of AFResult<T>.
     */
    
    //request<MoviesModel>
    // response<MoviesModel>
    //<T>
    
    // MARK: - Process
    func process<T:Codable>(response: DataResponse<T, AFError>,
                            decodedTo type: T.Type) -> AFResult<T> {
        
        switch response.result {
        case .success:
            guard let data = response.data else {
                return .failure(NSError.create(description:"Something went wrong") as! AFError)
            }
#if DEBUG
            print(JSON(response.data ?? [:]), "data before parsing")
#endif
            do {
                let data = try JSONDecoder.decodeFromData(type, data: data)
                print(JSON(response.data ?? [:]), "astrix data after parsing")
                return .success(data)
            } catch {
#if DEBUG
                print(type, String(describing: error))
#endif
                return .failure(AFError.responseSerializationFailed(reason: .customSerializationFailed(error: NSError.create(description: "Server Error."))))
            }
            
        case .failure(let error):
#if DEBUG
            print(type, String(describing: error))
#endif
            
            if error.localizedDescription.contains("JSON") {
                return .failure(AFError.responseSerializationFailed(reason: .customSerializationFailed(error: NSError.create(description: "Server Error."))))
            }
            return .failure(error)
        }
    }
    
}

/*
 This class is a custom implementation of the RequestAdapter protocol from Alamofire.
 It allows modifying requests before they are sent.
  */

// MARK: - Middleware
class NetworkMiddleware: RequestAdapter {
//     The adapt method is not implemented and does nothing.
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {}
    
    
    /*
     The sessionManager property is an instance of Session from Alamofire. It is initialized with a default URLSessionConfiguration from Alamofire, which is responsible for managing the session and its headers.
     The sessionManager is configured with global headers, such as "accept", "CLIENT-TYPE", and "CLIENT-VERSION", which will be included in every request made by the manager property of the NetworkConnectionGeneric class.
     */
    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default // Alamofire's default URLSessionConfiguration
        configuration.httpAdditionalHeaders = configuration.headers.dictionary
        
        // global headers
        configuration.headers["accept"] = "application/json"
//        configuration.headers["api_key"] = "cd99f2d3aa1f9678c32316de7e4f2ce1"
//        configuration.headers["api_key"] = "cd99f2d3aa1f9678c32316de7e4f2ce1"
//        configuration.headers["app-lang"] = "ar"
//        configuration.headers["CLIENT-TYPE"] = "ios"
//        configuration.headers["CLIENT-VERSION"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "2.0.0"

        
        // auth token
        //        if let token = AuthService.instance.apiToken {
        //            configuration.headers["Authorization"] = "Bearer \(token)"
        //        }
        
        return Session(configuration: configuration)
    }()
}

/*
 In summary, the code provides a generic network connection implementation using Alamofire. It handles GET and POST requests, processes the responses, and provides a completion handler for receiving the results. The NetworkMiddleware class is responsible for managing the session and headers.
 */


extension NSError {
    class func create(description: String) -> NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: description])
    }
}


