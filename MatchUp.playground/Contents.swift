import Foundation
import PlaygroundSupport
import _Concurrency

// This playground reuses code from the QuickUp project:
// https://github.com/katagaki/QuickUp
// Consider contributing to it if you want to see a faster,
// better, native ClickUp client for macOS.

// The current code only exports a CSV of matched tasks
// so that you can manually merge them in the ClickUp website.
// ClickUp has not yet provided an API for merging tasks
// on their official public API.

var output: String = "ListName,TaskName,MergeFromStatus,MergeToStatus,MergeFromDesc,MergeToDesc,MergeFromURL,MergeToURL"
var mergeFromFolderID: String = "<INSERT_FOLDER_ID_HERE>"
var mergeToFolderID: String = "<INSERT_FOLDER_ID_HERE>"

Task {
    
    let oldEpicLists = await getLists(folderID: mergeFromFolderID, archived: false)!.lists
    let newEpicLists = await getLists(folderID: mergeToFolderID, archived: false)!.lists
    
    for list in oldEpicLists {
        for newList in newEpicLists {
            if list.name == newList.name {
                let tasks = await getTasks(listID: list.id, archived: false, page: 0, orderBy: .ID, inReverseOrder: false, includeSubtasks: false, filterBy: [], includeClosed: true)!.tasks
                let newTasks = await getTasks(listID: newList.id, archived: false, page: 0, orderBy: .ID, inReverseOrder: false, includeSubtasks: false, filterBy: [], includeClosed: true)!.tasks
                for task in tasks {
                    
                    // Match task name
                    for newTask in newTasks {
                        if task.name.lowercased() == newTask.name.lowercased() && task.parent == nil && newTask.parent == nil {
                            
                            // Match tags
                            var tagCount = task.tags.count
                            var tagsMatchedCount = 0
                            for tag in task.tags {
                                if newTask.tags.contains(where: { newTaskTag in
                                    tag.name == newTaskTag.name
                                }) {
                                    tagsMatchedCount += 1
                                }
                            }
                            if tagCount == tagsMatchedCount {
                                
                                // Match first line of description (if you have an identifier)
                                let description = task.description ?? ""
                                let newDescription = newTask.description ?? ""
                                if description != "" && newDescription != "",
                                   description.components(separatedBy: CharacterSet.newlines).first ==
                                    newDescription.components(separatedBy: CharacterSet.newlines).first {
                                        
                                    // Parse description into CSV friendly format
                                    let csvCompatibleDescription = description
                                        .replacingOccurrences(of: "\"", with: "\"\"")
                                        .replacingOccurrences(of: "\n", with: "☃︎") // Replace ☃︎ with line break after processing CSV
                                    let csvCompatibleNewDescription = newDescription
                                        .replacingOccurrences(of: "\"", with: "\"\"")
                                        .replacingOccurrences(of: "\n", with: "☃︎") // Replace ☃︎ with line break after processing CSV
                                    
                                    // Add final result to output if all conditions pass
                                    output += "\n\"\(list.name)\",\"\(task.name)\",\(task.status.status),\(newTask.status.status),\"\(csvCompatibleDescription)\",\"\(csvCompatibleNewDescription)\",\(task.url),\(newTask.url)"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // TODO: Actually do merging when ClickUp decides to release their merge API
    
    let outputFileURL = playgroundSharedDataDirectory.appendingPathComponent("MergeData.csv")
    do {
        try output.write(to: outputFileURL, atomically: true, encoding: .utf8)
        print("Saved CSV.")
    } catch {
        print ("Error saving CSV:\n\n\(error)\n\nDid you remember to create the 'Shared Playground Data' folder in your Documents folder?")
    }

}
