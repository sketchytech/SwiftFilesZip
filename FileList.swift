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
    public static func allFilesAndFolders(path:String, inDirectory directory:NSSearchPathDirectory, subdirectory:String?) -> [NSURL]? {

        // Create load path
        let loadPath = buildPath(path, inDirectory: directory, subdirectory: subdirectory)
        
        let url = NSURL(fileURLWithPath: loadPath)
        var error:NSError?
        
        var properties = [NSURLLocalizedNameKey,
            NSURLCreationDateKey, NSURLLocalizedTypeDescriptionKey]
        if let url = url,
        array = NSFileManager.defaultManager().contentsOfDirectoryAtURL(url, includingPropertiesForKeys: properties, options:NSDirectoryEnumerationOptions.SkipsHiddenFiles, error: &error) as? [NSURL] {
        return array
        
}
        return nil
}
    
    public static func allFilesAndFoldersInTemporaryDirectory(path:String, inDirectory directory:NSSearchPathDirectory, subdirectory:String?) -> [NSURL]? {
        
        // Create load path
        let loadPath = buildPathToTemporaryDirectory(path, subdirectory: subdirectory)
        
        let url = NSURL(fileURLWithPath: loadPath)
        var error:NSError?
        
        var properties = [NSURLLocalizedNameKey,
            NSURLCreationDateKey, NSURLLocalizedTypeDescriptionKey]
        if let url = url,
            array = NSFileManager.defaultManager().contentsOfDirectoryAtURL(url, includingPropertiesForKeys: properties, options:NSDirectoryEnumerationOptions.SkipsHiddenFiles, error: &error) as? [NSURL] {
                return array
                
        }
        return nil
    }
    
    
    // private methods
    
    private static func buildPath(path:String, inDirectory directory:NSSearchPathDirectory, subdirectory:String?) -> String  {
        // Remove unnecessary slash if need
        let newPath = stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file load path
        var loadPath = ""
        
        if let direct = applicationDirectory(directory),
            path = direct.path {
                loadPath = path + "/"
        }
        
        if let sub = subDir {
            loadPath += sub
            loadPath += "/"
        }
        
        
        // Add requested load path
        loadPath += newPath
        return loadPath
    }
    public static func buildPathToTemporaryDirectory(path:String, subdirectory:String?) -> String {
        // Remove unnecessary slash if need
        let newPath = stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file load path
        var loadPath = ""
        
        if let direct = self.applicationTemporaryDirectory(),
            path = direct.path {
                loadPath = path + "/"
        }
        
        if let sub = subDir {
            loadPath += sub
            loadPath += "/"
        }
        
        
        // Add requested save path
        loadPath += newPath
        return loadPath
    }
    
    //directories
    private static func applicationDirectory(directory:NSSearchPathDirectory) -> NSURL? {
        
        var appDirectory:String?
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(directory, NSSearchPathDomainMask.UserDomainMask, true);
        if paths.count > 0 {
            if let pathString = paths[0] as? String {
                appDirectory = pathString
            }
        }
        if let dD = appDirectory {
            return NSURL(string:dD)
        }
        return nil
    }
    
    
    
    
    private static func applicationTemporaryDirectory() -> NSURL? {
        
        if let tD = NSTemporaryDirectory() {
            return NSURL(string:tD)
        }
        
        return nil
        
    }
    
    //pragma mark - strip slashes
    
    private static func stripSlashIfNeeded(stringWithPossibleSlash:String) -> String {
        var stringWithoutSlash:String = stringWithPossibleSlash
        // If the file name contains a slash at the beginning then we remove so that we don't end up with two
        if stringWithPossibleSlash.hasPrefix("/") {
            stringWithoutSlash = stringWithPossibleSlash.substringFromIndex(advance(stringWithoutSlash.startIndex,1))
        }
        // Return the string with no slash at the beginning
        return stringWithoutSlash
    }

}