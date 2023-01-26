//
//  Lists.swift
//  QuickUp
//
//  Created by 堅書 on 7/10/22.
//

import Foundation

public struct CUListsList: Codable {
    public var lists: [CUList]
}

public struct CUList: Codable {
    public var id: String
    public var name: String
    public var access: Bool?
    public var orderindex: Int?
    public var content: String?
    public var status: CUStatus?
    public var priority: CUPriority?
    public var assignee: CUMemberInfo?
    public var task_count: Int?
    public var due_date: String?
    public var start_date: String?
    public var folder: CUFolder?
    public var space: CUSpace?
    public var archived: Bool?
    public var override_statuses: Bool?
    public var statuses: [CUStatus]?
    public var permission_level: String?
}

public func getFolderLessLists(spaceID: String, archived: Bool = false) async -> CUListsList? {
    let request = request(url: "\(apiEndpoint)/space/\(spaceID)/list?archived=\(archived ? "true" : "false"))",
                          method: .GET)
    return await withCheckedContinuation { (continuation: CheckedContinuation<CUListsList?, Never>) in
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                continuation.resume(returning: nil)
            } else {
                if let data = data {
                    do {
                        let lists = try JSONDecoder().decode(CUListsList.self, from: data)
                        print("Fetched \(lists.lists.count) list(s).")
                        continuation.resume(returning: lists)
                    } catch {
                        print("An error occurred while fetching lists! This is the error: ")
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

public func getLists(folderID: String, archived: Bool = false) async -> CUListsList? {
    let request = request(url: "\(apiEndpoint)/folder/\(folderID)/list?archived=\(archived ? "true" : "false"))",
                          method: .GET)
    return await withCheckedContinuation { (continuation: CheckedContinuation<CUListsList?, Never>) in
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                continuation.resume(returning: nil)
            } else {
                if let data = data {
                    do {
                        let lists = try JSONDecoder().decode(CUListsList.self, from: data)
                        print("Fetched \(lists.lists.count) list(s).")
                        continuation.resume(returning: lists)
                    } catch {
                        print("An error occurred while fetching lists! This is the error: ")
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
