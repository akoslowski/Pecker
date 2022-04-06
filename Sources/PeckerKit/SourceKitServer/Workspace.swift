import Foundation
import IndexStoreDB

class Workspace {
    
    /// Build setup
    let buildSettings: DatabaseBuildSystem

    /// The source code index, if available.
    var index: IndexStoreDB? = nil
    
    /// The directory containing the original, unmodified project.
    init(buildSettings: DatabaseBuildSystem) throws {
        self.buildSettings = buildSettings

        let libIndexStoreDylibPath = buildSettings.xcodeAppPath.appending("/Toolchains/XcodeDefault.xctoolchain/usr/lib/libIndexStore.dylib")

        if let storePath = buildSettings.indexStorePath,
            let dbPath = buildSettings.indexDatabasePath {
            do {
                let lib = try IndexStoreLibrary(dylibPath: libIndexStoreDylibPath)
                self.index = try IndexStoreDB(
                    storePath: URL(fileURLWithPath: storePath).path,
                    databasePath: NSTemporaryDirectory() + "index_\(getpid())",
                    library: lib,
                    listenToUnitEvents: false)
                log("opened IndexStoreDB at \(dbPath) with store path \(storePath)")
            } catch {
                log("failed to open IndexStoreDB: \(error.localizedDescription)", level: .error)
            }
        }
    }
}
