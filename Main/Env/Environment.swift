//
//  Environment.swift
//  Main
//
//  Created by Anderson Chagas on 19/05/21.
//  Copyright © 2021 Anderson Chagas. All rights reserved.
//

import Foundation

public final class Environment {
    
    public enum EnvironmentVariables: String {
        case apiBaseUrl = "API_BASE_URL"
    }
    
    public static func variable(_ key: EnvironmentVariables) -> String {
        Bundle.main.infoDictionary![key.rawValue] as! String
    }
}
