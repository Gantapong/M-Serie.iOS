//
//  Configurators.swift
//  Solarlaa
//
//  Created by GISC on 30/7/2561 BE.
//  Copyright © 2561 Nortisgroup. All rights reserved.
//

import Foundation

enum Languages {
    case EN
    case TH
}

struct Configurators {
    
    static var languages: Languages = .EN
    static var timeoutForRequest = TimeInterval.init(60)
    
    struct messageTH {
        static let tryAgain = "กรุณาลองใหม่อีกครั้ง"
    }
    
    struct messageEN {
        static let tryAgain = "Please try again."
    }
    
}
