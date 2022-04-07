import Foundation
import SwiftSyntax
import TSCBasic
import TSCUtility

public struct XcodeReporter: Reporter {
    struct Location: DiagnosticLocation {
        let description: String
    }
    
    public func report(_ configuration: Configuration, sources: [SourceDetail]) {
        let diagnosticEngine = makeDiagnosticEngine()
        for source in sources {
            diagnosticEngine.emit(warning: "Pecker: '\(source.name)' was never used; consider removing it", location: Location(description: source.location.description))
        }
    }
}

/// Makes and returns a new configured diagnostic engine.
private func makeDiagnosticEngine() -> DiagnosticsEngine {
    let handler: DiagnosticsEngine.DiagnosticsHandler = { diagnostic in
        // </path/to/file.swift>:<line>:<column>: <warning>: <message>
        let message = "\(diagnostic.location): warning: \(diagnostic.localizedDescription)"
        print(message)
    }
    return DiagnosticsEngine(handlers: [handler])
}
