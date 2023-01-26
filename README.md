# MatchUp
Duplicate ClickUp task finder for folders

Easily find duplicate tasks in entire ClickUp folders with MatchUp, using just Xcode Playgrounds.

## Setting up

1. In `Sources/Global.swift`, enter your personal ClickUp API token for value of `apiKey`.
1. In `Contents.swift`, enter the source folder's ID for the value of `mergeFromFolderID`.
1. Enter the destination folder's ID for the value of `mergeToFolderID`.
    - If you want to search within a folder, use the same ID as the source folder's ID.
    - If you enter a different ID for the destination, MatchUp will compare tasks between the source folder and destination folder for duplicates.
    - If you enter the same ID for the destination as the source, MatchUp will compare tasks within the folder one way (it will not produce A>B, B>A type duplicates).
1. In your Documents folder, create a `Shared Playground Data` folder.
1. Run the playground in Xcode.

## Using the results

- You can use [DoubleClickUp](https://github.com/katagaki/DoubleClickUp) to quickly view duplicate tasks and merge them.
    - For this purpose, a DoubleClickUp-compatible CSV is generated.
- You can analyze the tasks manually using Numbers/Excel.
