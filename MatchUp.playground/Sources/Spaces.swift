//
//  Spaces.swift
//  QuickUp
//
//  Created by 堅書 on 7/10/22.
//

import Foundation

public struct CUSpaceList: Codable {
    public var spaces: [CUSpace]
}

public struct CUSpace: Codable {
    public var id: String
    public var name: String?
    public var `private`: Bool?
    public var statuses: [CUStatus]?
    public var multiple_assignees: Bool?
    public var features: CUSpaceFeatureConfiguration?
    public var access: Bool?
}

public struct CUSpaceFeatureConfiguration: Codable {
    public var due_dates: CUDueDatesConfiguration?
    public var time_tracking: CUTimeTrackingConfiguration?
    public var tags: CUTagsConfiguration?
    public var time_estimates: CUTimeEstimatesConfiguration?
    public var checklists: CUChecklistsConfiguration?
    public var custom_fields: CUCustomFieldsConfiguration?
    public var remap_dependencies: CURemapDependenciesConfiguration?
    public var dependency_warning: CUDependencyWarningConfiguration?
    public var portfolios: CUPortfoliosConfiguration?
}

public struct CUDueDatesConfiguration: Codable {
    public var enabled: Bool
    public var start_date: Bool
    public var remap_due_dates: Bool
    public var remap_closed_due_date: Bool
}

public struct CUTimeTrackingConfiguration: Codable {
    public var enabled: Bool
}

public struct CUTagsConfiguration: Codable {
    public var enabled: Bool
}

public struct CUTimeEstimatesConfiguration: Codable {
    public var enabled: Bool
}

public struct CUChecklistsConfiguration: Codable {
    public var enabled: Bool
}

public struct CUCustomFieldsConfiguration: Codable {
    public var enabled: Bool
}

public struct CURemapDependenciesConfiguration: Codable {
    public var enabled: Bool
}

public struct CUDependencyWarningConfiguration: Codable {
    public var enabled: Bool
}

public struct CUPortfoliosConfiguration: Codable {
    public var enabled: Bool
}
