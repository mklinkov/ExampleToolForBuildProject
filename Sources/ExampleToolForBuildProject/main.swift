import Foundation
import SwiftToolShellExecutor
import ArgumentParser

let defaultHomeDirectory = FileManager.default.homeDirectoryForCurrentUser
let simulatorName = "iPhone 12 Pro"
let osVerion = 15.2

struct Runer: ParsableCommand {

    /// target path on your coputer
    @Argument()
    var directoryPath: String = defaultHomeDirectory.path

    /// repository url
    @Argument()
    var repositoryPath: String = "https://github.com/mklinkov/EmptyProject.git"

    // path with project
    @Argument()
    var sourcePath: String = "EmptyProject"

    /// project target name
    @Argument()
    var targetName: String = "EmptyProject"

    func run() throws {
        let path = directoryPath
        let absolutePath = "\(path)/tempFolder/"

        if !FileManager.default.fileExists(atPath: absolutePath) {
            do {
                try FileManager.default.createDirectory(atPath: absolutePath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("createDirectory \(error.localizedDescription)")
            }
        } else {
            try? FileManager.default.removeItem(atPath: "\(absolutePath)/\(sourcePath)")
        }

        Shell.run("cd \(absolutePath); git clone \(repositoryPath) -b main")

        let runTest = """
            cd \(absolutePath)/\(sourcePath);
            xcodebuild test \
            -scheme \(targetName) \
            -project \(targetName).xcodeproj \
            -sdk iphonesimulator \
            -destination 'platform=iOS Simulator,name=\(simulatorName),OS=\(osVerion)' \
            test \
              | bundle exec xcpretty --test --color
            """

        Shell.run(runTest)

        Runer.exit()
    }
}

Runer.main()
