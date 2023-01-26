//
//  Folders.swift
//  QuickUp
//
//  Created by 堅書 on 7/10/22.
//

import Foundation

public struct CUFolderList: Codable {
    public var folders: [CUFolder]
}

public struct CUFolder: Codable {
    public var id: String
    public var name: String
    public var orderindex: Int?
    public var override_statuses: Bool?
    public var hidden: Bool
    public var space: CUSpace?
    public var task_count: String?
    public var lists: [CUList]?
    public var permission_level: String?
    public var access: Bool?
}

public func getFolders(spaceID: String, archived: Bool = false) async -> CUFolderList? {
    let request = request(url: "\(apiEndpoint)/space/\(spaceID)/folder?archived=\(archived ? "true" : "false"))",
                          method: .GET)
    return await withCheckedContinuation { (continuation: CheckedContinuation<CUFolderList?, Never>) in
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                continuation.resume(returning: nil)
            } else {
                if let data = data {
                    do {
                        let folders = try JSONDecoder().decode(CUFolderList.self, from: data)
                        print("Fetched \(folders.folders.count) folder(s).")
                        continuation.resume(returning: folders)
                    } catch {
                        print("An error occurred while fetching folders! This is the error: ")
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
