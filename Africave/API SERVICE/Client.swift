//
//  Client.swift
//  Africave
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 Oladipupo Oluwatobi. All rights reserved.
//

import Foundation

class  Client {
    
    struct Auth {
          static var postId = 0
          static var requestToken = ""
          static var sessionId = ""
      }
        
    enum Endpoints {
 
        case login
        case signup
        case getPost
        case getSinglePost
        case hashtagPost
        case createNewPost

        
        var stringValue: String {
            switch self {
                
            case .signup:
                return  "https://ios-test-january-2020.africave.co/api/v1/register"
            case .login:
                return "https://ios-test-january-2020.africave.co/api/v1/login"
            case .getPost:
                return "https://ios-test-january-2020.africave.co/api/v1/posts?limit=2&offset=0"
            case .getSinglePost:
                return "https://ios-test-january-2020.africave.co/api/v1/posts/1"
            case .hashtagPost:
                return "https://ios-test-january-2020.africave.co/api/v1/explore/ios?limit=2&offset=0"
                
            case .createNewPost:
                return "https://ios-test-january-2020.africave.co/api/v1/posts"
       
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }

 class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
     var request = URLRequest(url: url)
     request.httpMethod = "POST"
     request.httpBody = try! JSONEncoder().encode(body)
     request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     let task = URLSession.shared.dataTask(with: request) { data, response, error in
         guard let data = data else {
             DispatchQueue.main.async {
                 completion(nil, error)
             }
             return
         }
         let decoder = JSONDecoder()
         do {
             let responseObject = try decoder.decode(ResponseType.self, from: data)
             DispatchQueue.main.async {
                 completion(responseObject, nil)
             }
         } catch {
             do {
                 let errorResponse = try decoder.decode(AfricaveResponse.self, from: data) as Error
                 DispatchQueue.main.async {
                     completion(nil, errorResponse)
                 }
             } catch {
                 DispatchQueue.main.async {
                     completion(nil, error)
                 }
             }
         }
     }
     task.resume()
 }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(Auth.requestToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(AfricaveResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        
        return task
    }

    
    class func signup(username: String, password: String, email: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = SignUpRequest(username: username, email: email, password: password)
        taskForPOSTRequest(url: Endpoints.signup.url, responseType: SignUpResponse.self, body: body) { response, error in
            if let response = response {
                 Auth.requestToken = response.token
                //print(response.token)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func login(password: String, email: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = SignInRequest(email: email, password: password)
        taskForPOSTRequest(url: Endpoints.login.url, responseType: SignInResponse.self, body: body) { response, error in
            if let response = response {
                Auth.requestToken = response.token
                //print(Auth.requestToken)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    
    class func getPost(completion: @escaping ([Post], Error?) -> Void) {
          taskForGETRequest(url: Endpoints.getPost.url, responseType: Postresults.self) { response, error in
              if let response = response {
                //print(response.posts)
                completion(response.posts, nil)
              } else {
                //print(error!)
                  completion([], error)
              }
          }
      }
    
    class func getSinglePost(completion: @escaping ([Post], Error?) -> Void) {
          taskForGETRequest(url: Endpoints.getSinglePost.url, responseType: SInglePost.self) { response, error in
              if let response = response {
                print(response.posts)
                completion([response.posts], nil)
              } else {
                
                completion([], error)
                print(error!)
              }
          }
      }
    
    class func hashtagPost(completion: @escaping ([Post], Error?) -> Void) {
          taskForGETRequest(url: Endpoints.hashtagPost.url, responseType: Postresults.self) { response, error in
              if let response = response {
                //print(response)
                completion(response.posts, nil)
                } else {
                print(error!)
                completion([], error)
                }
          }
      }

    class func createNewPost(title: String, description: String, hashtags: String, completion: @escaping (Bool, Error?) -> Void) {
     let body = CreatePostResquest(title: title, description: description, hashtags: hashtags)
     taskForPOSTRequest(url: Endpoints.createNewPost.url, responseType: SignInResponse.self, body: body) { response, error in
         if let response = response {
             Auth.requestToken = response.token
             //print(Auth.requestToken)
             completion(true, nil)
         } else {
             completion(false, error)
         }
     }
 }


}
