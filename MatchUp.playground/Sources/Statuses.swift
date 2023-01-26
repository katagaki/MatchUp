//
//  Statuses.swift
//  QuickUp
//
//  Created by 堅書 on 7/10/22.
//

import Foundation

public struct CUStatus: Codable {
    public var id: String?
    public var status: String
    public var color: String
    public var orderindex: Int?
    public var type: String?
    public var hide_label: Bool?
}
