//
//  CustomFields.swift
//  QuickUp
//
//  Created by 堅書 on 8/10/22.
//

import Foundation

public struct CUCustomField: Codable {
    public var id: String
    public var name: String
    public var type: String
    public var type_config: CUCustomFieldConfig?
    public var date_created: String?
    public var hide_from_guests: Bool
    public var required: Bool?
}

public struct CUCustomFieldConfig: Codable {
    public var new_drop_down: Bool?
    public var options: [CUCustomFieldConfigOption]?
    public var end: Int?
    public var start: Int?
}

public struct CUCustomFieldConfigOption: Codable {
    public var id: String
    public var name: String?
    public var label: String?
    public var color: String?
    public var orderindex: Int?
}
