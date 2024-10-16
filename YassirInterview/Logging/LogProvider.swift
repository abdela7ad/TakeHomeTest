//
//  LogProvider.swift
//  YassirInterview
//
//  Created by Abdelahad on 16/10/2024.
//

protocol LogProvider {
    func internalError( context: [String: Any]?, error: Error?, file: String, method: String, line: Int)
}

extension LogProvider {
    

    func error(file: String = #fileID, method: String = #function, line: Int = #line) {
        self.internalError(context: nil,
                           error: nil,
                           file: nameFromPath( file ),
                           method: method,
                           line: line)
    }
    
    func error(error: Error, file: String = #fileID, method: String = #function, line: Int = #line) {
        self.internalError( context: nil,
                            error: error,
                            file: nameFromPath( file ),
                            method: method,
                            line: line)
    }
    
    private func nameFromPath( _ path: String) -> String {
        return String( path.split(separator: "/").last!)
    }
}

final class ConsoleLogger: LogProvider {
    
    func internalError(context: [String : Any]?, error: (any Error)?, file: String, method: String, line: Int) {
        var str = "[ERROR] - \(file):\(line) - \(method)"
        
        if let context {
            context.forEach { (key: String, value: Any) in
                str += "; \(key): \(value)"
            }
        }
        if let error {
            str += "; Error: \(error)"
        }

        // write error to the console
        print(str)
    }
    
}
