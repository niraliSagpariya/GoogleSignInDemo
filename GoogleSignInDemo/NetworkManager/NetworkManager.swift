
import Foundation

enum NetworkManagerError: Error {
  case badResponse(URLResponse?)
  case badData
  case badLocalUrl
}

fileprivate struct APIResponse: Codable {
  let results: [Post]
}

class NetworkManager {
    
    private enum Constants {
        static  let accessKey = "bbc33cc9f86e189e1387e31a57dbd74a2dba4a5f4540f7a0dbcb599fd72f61f2"
    }
    
  static var shared = NetworkManager()
  private var images = NSCache<NSString, NSData>()
  let session: URLSession
  
  init() {
    let config = URLSessionConfiguration.default
    session = URLSession(configuration: config)
  }
  
  private func components() -> URLComponents {
    var comp = URLComponents()
    comp.scheme = "https"
    comp.host = "api.unsplash.com"
    return comp
  }
  
  private func request(url: URL) -> URLRequest {
    var request = URLRequest(url: url)
      request.addValue("Client-ID \(Constants.accessKey)", forHTTPHeaderField: "Authorization")
    return request
  }
  
  func posts(query: String, completion: @escaping ([Post]?, Error?) -> (Void)) {
    var comp = components()
    comp.path = "/search/photos"
    comp.queryItems = [
      URLQueryItem(name: "query", value: query)
    ]
    let req = request(url: comp.url!)
    
    let task = session.dataTask(with: req) { data, response, error in
      if let error = error {
        completion(nil, error)
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        completion(nil, NetworkManagerError.badResponse(response))
        return
      }
      
      guard let data = data else {
        completion(nil, NetworkManagerError.badData)
        return
      }
      
      do {
        let response = try JSONDecoder().decode(APIResponse.self, from: data)
        completion(response.results, nil)
      } catch let error {
        completion(nil, error)
      }
    }
    
    task.resume()
  }
}
