//
//  FileLoad.swift
//
//  Created by Anthony Levings on 25/06/2014.

//

import Foundation

public struct FileLoad {
    
    
    public static func loadData(path:String, directory:FileManager.SearchPathDirectory, subdirectory:String?) -> Data?
    {
        
        let loadPath = buildPath(path: path, inDirectory: directory, subdirectory: subdirectory)
        // load the file and see if it was successful
        let data = FileManager.default.contents(atPath: loadPath)
        // Return data
        return data
        
    }
    
    
    public static func loadDataFromTemporaryDirectory(path:String, subdirectory:String?) -> Data?
    {
        
        
        let loadPath = buildPathToTemporaryDirectory(path: path, subdirectory: subdirectory)
        // Save the file and see if it was successful
        let data = FileManager.default.contents(atPath: loadPath)
        
        // Return status of file save
        return data
        
        
    }
    
    
    // string methods
    
    public static func loadString(path:String, directory:FileManager.SearchPathDirectory, subdirectory:String?, encoding enc:String.Encoding = String.Encoding.utf8) throws -> String?
    {
        let loadPath = buildPath(path: path, inDirectory: directory, subdirectory: subdirectory)
        
        
        
        // Save the file and see if it was successful
        let text:String? = try String(contentsOfFile:loadPath, encoding:enc)
        
        
        return text
        
    }
    
    
    public static func loadStringFromTemporaryDirectory(path:String, subdirectory:String?, encoding enc:String.Encoding = String.Encoding.utf8) throws -> String? {
        
        let loadPath = buildPathToTemporaryDirectory(path: path, subdirectory: subdirectory)
        
        
        // Save the file and see if it was successful
        let text:String? = try String(contentsOfFile:loadPath, encoding:enc)
        
        
        return text
        
    }
    
    
    
    // private methods
    
    private static func buildPath(path:String, inDirectory directory:FileManager.SearchPathDirectory, subdirectory:String?) -> String  {
        // Remove unnecessary slash if need
        let newPath = FileHelper.stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = FileHelper.stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file load path
        var loadPath = ""
        
        if let direct = FileDirectory.applicationDirectory(directory) {
            loadPath = direct.path + "/"
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
        let newPath = FileHelper.stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = FileHelper.stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file load path
        var loadPath = ""
        
        if let direct = FileDirectory.applicationTemporaryDirectory() {
            loadPath = direct.path + "/"
        }
        
        if let sub = subDir {
            loadPath += sub
            loadPath += "/"
        }
        
        
        // Add requested save path
        loadPath += newPath
        return loadPath
    }
    
    
    
    
    
}
