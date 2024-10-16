//
//  NetworkProvider.swift
//  YassirInterview
//
//  Created by Abdelahad on 15/10/2024.
//

import Foundation

public protocol NetworkProvider {
    func sendAndRetrieve<Response: Decodable>(method: HTTPMethod, destination: URL) async throws -> Response
}

final class BasicNetworkProvider: NetworkProvider {
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func sendAndRetrieve<Response: Decodable>(method: HTTPMethod, destination: URL) async throws -> Response {
        var request = URLRequest(url: destination)
        request.httpMethod = method.rawValue
        
        do {

            let (data, response) = try await self.session.data(for: request)
            let result = try confirmResponse(
                data: data,
                response: response,
                type: Response.self,
                method: request.httpMethod,
                url: destination
            )
            return result
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unexpected(
                message: "Failed to send",
                innerError: error
            )
        }
    }
    
    private func confirmResponse<Response: Decodable>(
        data: Data,
        response: URLResponse,
        type: Response.Type,
        method: String?,
        url: URL
    ) throws -> Response {
 
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unexpected(message: "Returned a non-HTTPURLResponse (very strange!)")
        }
        let code = httpResponse.statusCode
        guard (200...299).contains(code) else {
            throw NetworkError.non200Code(errorCode: code)
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw error
        }
    }
    
    private let session: URLSession
}


