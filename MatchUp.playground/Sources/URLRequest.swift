//
//  URLRequest.swift
//  QuickUp
//
//  Created by 堅書 on 7/10/22.
//

import Foundation

func request(url: String, method: URLRequestMethod, body: String? = nil) -> URLRequest {
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "\(method)"
    request.addValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
    request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.addValue(apiKey, forHTTPHeaderField: "Authorization")
    if let body = body {
        request.httpBody = body.data(using: .utf8)
    }
    return request
}

enum URLRequestMethod {
    case GET
    case POST
    case PUT
}
