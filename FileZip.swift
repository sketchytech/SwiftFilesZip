//
//  FileZip.swift
//  SwiftFilesZip
//
//  Created by Anthony Levings on 30/04/2015.
//  Copyright (c) 2015 Gylphi. All rights reserved.
//

import Foundation

open class FileZip {
    
    open static func unzipFile(_ path:String, toDirectory directory:FileManager.SearchPathDirectory, subdirectory:String?) {
        // Remove unnecessary slash if need
        let newPath = stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file save path
        var savePath = ""
        
        if let direct = applicationDirectory(directory) {
                savePath = direct.path + "/"
        }
        
        
        if let sub = subDir {
            savePath += sub
            savePath += "/"
        }
        
        // Add requested save path

        SSZipArchive.unzipFile(atPath: path, toDestination: savePath)
    }
    open static func unzipFileToTemporaryDirectory(_ path:String, subdirectory:String?) {
        // Remove unnecessary slash if need
        // Remove unnecessary slash if need
        let newPath = stripSlashIfNeeded(path)
        var subDir:String?
        if let sub = subdirectory {
            subDir = stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file save path
        var savePath = ""
        if let direct = applicationTemporaryDirectory() {
        savePath = direct.path + "/"
        }
        
        if let sub = subDir {
            savePath += sub
            savePath += "/"
        }
        

        SSZipArchive.unzipFile(atPath: path, toDestination: savePath)
    }
    
    open static func unzipEPUB(_ path:String, subdirectory:String?) -> [URL] {
        
        let subD = subdirectory ?? ""
        // TODO: this works but don't force unwrap here!
        unzipFileToTemporaryDirectory(path, subdirectory: "EPUB/" + subD)
        
        
        var subDir:String?
        if let sub = subdirectory {
            subDir = stripSlashIfNeeded(sub)
        }

        var savePath = ""
        
        if let direct = applicationTemporaryDirectory() {
        savePath = direct.path + "/EPUB/"
        }
        if let sub = subDir {
            savePath += sub
            savePath += "/"
        }
        return EPUBContainerParser().parseXML(URL(fileURLWithPath: savePath))
    }
    
    
    
    // private methods
    
    //directories
    fileprivate static func applicationDirectory(_ directory:FileManager.SearchPathDirectory) -> URL? {
        
        var appDirectory:String?
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(directory, FileManager.SearchPathDomainMask.userDomainMask, true) as [AnyObject];
        if paths.count > 0 {
            if let pathString = paths[0] as? String {
                appDirectory = pathString
            }
        }
        if let dD = appDirectory {
            return URL(string:dD)
        }
        return nil
    }
    
    
    
    
    fileprivate static func applicationTemporaryDirectory() -> URL? {
        
        let tD = NSTemporaryDirectory()
        return URL(string:tD)
        
        
        
    }
    
    //pragma mark - strip slashes
    
    fileprivate static func stripSlashIfNeeded(_ stringWithPossibleSlash:String) -> String {
        var stringWithoutSlash:String = stringWithPossibleSlash
        // If the file name contains a slash at the beginning then we remove so that we don't end up with two
        if stringWithPossibleSlash.hasPrefix("/") {
            stringWithoutSlash = stringWithPossibleSlash.substring(from: stringWithoutSlash.characters.index(stringWithoutSlash.startIndex, offsetBy: 1))
        }
        // Return the string with no slash at the beginning
        return stringWithoutSlash
    }
    
    
}
