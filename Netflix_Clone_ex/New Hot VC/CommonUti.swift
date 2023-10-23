//
//  CommonUti.swift
//  Netflix_Clone_ex
//
//  Created by Designer on 2023/08/01.
//

import UIKit

class CommonUti {

    static func iso8601(date: String, format: String) -> String {
        
        let formatter = ISO8601DateFormatter()
        
        if let isoDate = formatter.date(from: date) {
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = format
            let dateString = myFormatter.string(from: isoDate)
            
            return dateString
        }
        
        return ""
    }
}
