//
//  TypeInfo.swift
//  Netflix_Clone_ex
//
//  Created by Designer on 2023/07/20.
//

import Foundation
// movie, podcast, music, musicVideo, audiobook, shortFilm, tvShow, software, ebook, all
enum MediaType: Int, CaseIterable {
    case movie
    case podcast
    case music
    case musicVideo
    case audiobook
//    case shortFilm
//    case tvShow
    case software
    case ebook
    
    var queryValue: String {
        return "\(self)"
    }
    
    var title: String {
        switch self {
        case .movie:
            return "영화"
        case .podcast:
            return "팟캐스트"
        case .music:
            return "음악"
        case .musicVideo:
            return "뮤직비디오"
        case .audiobook:
            return "오디오북"
//        case .tvShow:
//            return "TV쇼"
        case .software:
            return "소프트웨어"
        case .ebook:
            return "E-북"
            
//        case .shortFilm:
//            return "숏필름"
        }
        
    }
    
}
