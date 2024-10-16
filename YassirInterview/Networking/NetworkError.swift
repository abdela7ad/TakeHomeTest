//
//  NetworkError.swift
//  YassirInterview
//
//  Created by Abdelahad on 16/10/2024.
//
public enum NetworkError: Error {
    
    /// An error happened that was unexpected.  An example could be JSON format
    /// failures of response objects
    case unexpected(message: String, innerError: Error? = nil)

    /// A non-200 series code was returned and extended info
    case non200Code(errorCode: Int)
    
    /// A response that was supposed to contain Data had none
    case noData
}
