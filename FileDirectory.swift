import Foundation

public struct FileDirectory {
    public static func applicationDirectory(_ directory:FileManager.SearchPathDirectory, subdirectory:String? = nil) -> URL? {
    
    
    if let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    {
        if let subD = subdirectory {
            return URL(fileURLWithPath:documentsDirectoryPath).appendingPathComponent(subD)
        }
        else {
            return URL(fileURLWithPath:documentsDirectoryPath)
        }
    }
    else {
     return nil
    }
}

public static func applicationTemporaryDirectory() -> URL? {
    
        let tD = NSTemporaryDirectory()
    
        return URL(string:tD)
    
}
}
