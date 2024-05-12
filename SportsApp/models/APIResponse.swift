//
//  BaseModel.swift
//  SportsApp
//
//  Created by Apple on 12/05/2024.
//

import Foundation

class APIResponse<T: Decodable>: Decodable {
    let success: Int?
    let result: [T]?
}
