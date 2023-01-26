//
//  Tasks.swift
//  QuickUp
//
//  Created by 堅書 on 8/10/22.
//

import Foundation

public struct CUTasksList: Codable {
    public var tasks: [CUTask]
}

public struct CUTask: Codable, Identifiable {
    public var id: String
    public var custom_id: String?
    public var name: String
    public var text_content: String?
    public var description: String?
    public var status: CUStatus
    public var orderindex: String
    public var date_created: String
    public var date_updated: String
    public var date_closed: String?
    public var archived: Bool
    public var creator: CUMemberInfo
    public var assignees: [CUMemberInfo]
    public var watchers: [CUMemberInfo]
    public var checklists: [CUTaskChecklist]?
    public var tags: [CUTaskTag]
    public var parent: String?
    public var priority: CUPriority?
    public var due_date: String?
    public var start_date: String?
    public var points: Int?
    public var time_estimate: Int?
    public var custom_fields: [CUCustomField]
    public var dependencies: [CUTaskDependency]
    public var linked_tasks: [CUTaskLink]
    public var team_id: String
    public var url: String
    public var permission_level: String
    public var list: CUList
    public var project: CUFolder
    public var folder: CUFolder
    public var space: CUSpace
}

public struct CUTaskChecklist: Codable {
    public var id: String
    public var task_id: String
    public var name: String
    public var date_created: String
    public var orderindex: Int
    public var creator: Int
    public var resolved: Int
    public var unresolved: Int
    public var items: [CUTaskChecklistItem]
}

public struct CUTaskChecklistItem: Codable {
    public var id: String
    public var name: String
    public var orderindex: Int
    public var assignee: CUMemberInfo?
    public var group_assignee: String?
    public var resolved: Bool
    public var parent: String?
    public var date_created: String
    public var children: [String]
}

public struct CUTaskTag: Codable {
    public var name: String
    public var tag_fg: String
    public var tag_bg: String
    public var creator: Int?
}

public struct CUTaskDependency: Codable {
    public var task_id: String
    public var depends_on: String
    public var type: Int
    public var date_created: String
    public var userid: String
    public var workspace_id: String
}

public struct CUTaskLink: Codable {
    public var task_id: String
    public var link_id: String
    public var date_created: String
    public var userid: String
    public var workspace_id: String?
}

public enum CUTaskOrder: String {
    case ID = "id"
    case CreatedDate = "created"
    case UpdatedDate = "updated"
    case DueDate = "due_date"
}

public func getTasks(listID: String,
              archived: Bool = false,
              page: Int = 0,
              orderBy order: CUTaskOrder = .CreatedDate,
              inReverseOrder reversed: Bool = false,
              includeSubtasks: Bool = false,
              filterBy statuses: [String] = [],
              includeClosed: Bool = false) async -> CUTasksList? {
    let statusQuery = statuses.reduce("statuses=") { s1, s2 in
        s1 + "&statuses=" + s2
    }
    let request = request(url: "\(apiEndpoint)/list/\(listID)/task?archived=\(archived ? "true" : "false")&page=\(page)&\(order.rawValue)&reverse=\(reversed ? "true" : "false")&subtasks=\(includeSubtasks ? "true" : "false")&\(statusQuery)&include_closed=\(includeClosed ? "true" : "false")",
                          method: .GET)
    // TODO: assignees; tags; due_date_gt; due_date_lt; date_created_gt; date_created_lt; date_updated_gt; date_updated_lt; custom_fields
    return await withCheckedContinuation { (continuation: CheckedContinuation<CUTasksList?, Never>) in
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                continuation.resume(returning: nil)
            } else {
                if let data = data {
                    do {
                        let tasks = try JSONDecoder().decode(CUTasksList.self, from: data)
                        print("Fetched \(tasks.tasks.count) task(s).")
                        continuation.resume(returning: tasks)
                    } catch {
                        print("An error occurred while fetching tasks! This is the error: ")
                        print(String(data: data, encoding: .utf8)!)
                        print(error)
                        continuation.resume(returning: nil)
                    }
                } else {
                    print("No data returned.")
                    continuation.resume(returning: nil)
                }
            }
        }.resume()
    }
}
