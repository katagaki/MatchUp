//
//  Users.swift
//  QuickUp
//
//  Created by 堅書 on 7/10/22.
//

import Foundation

public struct CUMember: Codable {
    public var user: CUMemberInfo
}

public struct CUMemberInfo: Codable {
    public var id: Int?
    public var username: String?
    public var color: String?
    public var initials: String?
    public var email: String?
    public var profilePicture: String?
}
