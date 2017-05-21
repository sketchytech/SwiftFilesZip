import Foundation


public struct FileSave {
    
    
    public static func saveData(fileData:Data, directory:FileManager.SearchPathDirectory, path:String, subdirectory:String?) throws -> Bool
    {
        
        let savePath = try buildPath(path: path, inDirectory: directory, subdirectory: subdirectory)
        // Save the file and see if it was successful
        let ok:Bool = FileManager.default.createFile(atPath: savePath,contents:fileData, attributes:nil)
        
        // Return status of file save
        return ok
        
    }
    
    public static func saveDataToTemporaryDirectory(fileData:Data, path:String, subdirectory:String?) throws -> Bool
    {
        
        let savePath = try buildPathToTemporaryDirectory(path: path, subdirectory: subdirectory)
        // Save the file and see if it was successful
        let ok:Bool = FileManager.default.createFile(atPath: savePath,contents:fileData, attributes:nil)
        
        // Return status of file save
        return ok
    }
    
    
    // string methods
    
    public static func saveString(fileString:String, directory:FileManager.SearchPathDirectory, path:String, subdirectory:String) throws {
        let savePath = try buildPath(path: path, inDirectory: directory, subdirectory: subdirectory)
        
        // Save the file and see if it was successful
        
        try fileString.write(toFile: savePath, atomically:false, encoding:String.Encoding.utf8)
        
        
        // Return status of file save
        
        
    }
    public static func saveStringToTemporaryDirectory(fileString:String, path:String, subdirectory:String) throws {
        
        let savePath = try buildPathToTemporaryDirectory(path: path, subdirectory: subdirectory)
        
        // Save the file and see if it was successful
        try fileString.write(toFile: savePath, atomically:false, encoding:String.Encoding.utf8)
        
    }
    
    
    
    
    // private methods
    public static func buildPath(path:String, inDirectory directory:FileManager.SearchPathDirectory, subdirectory:String?) throws -> String  {
        // Remove unnecessary slash if need
        let newPath = FileHelper.stripSlashIfNeeded(path)
        var newSubdirectory:String?
        if let sub = subdirectory {
            newSubdirectory = FileHelper.stripSlashIfNeeded(sub)
        }
        // Create generic beginning to file save path
        var savePath = ""
        if let direct = FileDirectory.applicationDirectory(directory)  {
            savePath = direct.path + "/"
        }
        
        if (newSubdirectory != nil) {
            savePath = savePath.appendingFormat(newSubdirectory!)
            try FileHelper.createSubDirectory(savePath)
            savePath += "/"
        }
        
        // Add requested save path
        savePath += newPath
        
        return savePath
    }
    
    public static func buildPathToTemporaryDirectory(path:String, subdirectory:String?) throws -> String {
        // Remove unnecessary slash if need
        let newPath = FileHelper.stripSlashIfNeeded(path)
        var newSubdirectory:String?
        if let sub = subdirectory {
            newSubdirectory = FileHelper.stripSlashIfNeeded(sub)
        }
        
        // Create generic beginning to file save path
        var savePath = ""
        if let direct = FileDirectory.applicationTemporaryDirectory() {
            savePath = direct.path + "/"
        }
        
        if let sub = newSubdirectory {
            savePath += sub
            try FileHelper.createSubDirectory(savePath)
            savePath += "/"
        }
        
        // Add requested save path
        savePath += newPath
        return savePath
    }
    
    
    
    
}
