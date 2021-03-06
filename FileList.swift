//
//  FileList.swift
//  SwiftFilesZip
//
//  Created by Anthony Levings on 30/04/2015.
//  Copyright (c) 2015 Gylphi. All rights reserved.
//

import Foundation
// see here for Apple's ObjC Code https://developer.apple.com/library/mac/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/AccessingFilesandDirectories/AccessingFilesandDirectories.html
public class FileList {
    public static func allFilesAndFolders(inDirectory directory:FileManager.SearchPathDirectory, subdirectory:String?) throws -> [URL]? {
        
        // Create load path
        if let loadPath = buildPathToDirectory(directory: directory, subdirectory: subdirectory) {
            
            let url = URL(fileURLWithPath: loadPath)
            
            let properties = [URLResourceKey.localizedNameKey,
                              URLResourceKey.creationDateKey, URLResourceKey.localizedTypeDescriptionKey]
            
            let array = try  FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: properties, options:FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            return array
            
        }
        return nil
    }
    
    public static func allFilesAndFoldersInTemporaryDirectory(subdirectory:String?) throws -> [URL]? {
        
        // Create load path
        let loadPath = buildPathToTemporaryDirectory(subdirectory: subdirectory)
        
        let url = URL(fileURLWithPath: loadPath)
        
        
        let properties = [URLResourceKey.localizedNameKey,
                          URLResourceKey.creationDateKey, URLResourceKey.localizedTypeDescriptionKey]
        
        let array = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: properties, options:FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
        return array
        
        
        
    }
    
    
    // private methods
    
    private static func buildPathToDirectory(directory:FileManager.SearchPathDirectory, subdirectory:String?) -> String?  {
        // Remove unnecessary slash if need
        // Remove unnecessary slash if need
        var subDir = ""
        if let sub = subdirectory {
            subDir = FileHelper.stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file delete path
        var buildPath = ""
        
        if let direct = FileDirectory.applicationDirectory(directory) {
            buildPath = direct.path + "/"
        }
        
        
        buildPath += subDir
        buildPath += "/"
        
        
        var dir:ObjCBool = true
        let dirExists = FileManager.default.fileExists(atPath: buildPath, isDirectory:&dir)
        if dir.boolValue == false {
            return nil
        }
        if dirExists == false {
            return nil
        }
        return buildPath
    }
    public static func buildPathToTemporaryDirectory(subdirectory:String?) -> String {
        // Remove unnecessary slash if need
        
        var subDir:String?
        if let sub = subdirectory {
            subDir = FileHelper.stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file load path
        var loadPath = ""
        
        if let direct = FileDirectory.applicationTemporaryDirectory()
            {
            loadPath = direct.path + "/"
        }
        
        if let sub = subDir {
            loadPath += sub
            loadPath += "/"
        }
        
        
        // Add requested save path
        return loadPath
    }
    
    
    
}
