import Foundation

public struct YamlConfiguration: Decodable {
    
    /// Rule identifiers to exclude from running
    public let disabledRules: [RuleType]?
    
    /// Output type
    public let reporter: ReporterType?
    
    /// index Store Path
    public let indexStorePath: String?
    
    /// Paths to include during detecting
    public let included: [String]?
    
    /// Paths to ignore during detecting
    public let excluded: [String]?
    
    /// name of group to ignore
    public let excludedGroupName: [String]?
    
    /// Acts as a blacklist, the  Files specified in this list will ignore
    public let blacklistFiles: [String]?
    
    /// Acts as a blacklist, the  symbols specified in this list will ignore
    public let blacklistSymbols: [String]?
    
    /// Acts as a blacklist, all the class inherit from class specified in the list will ignore
    public let blacklistSuperClass: [String]?
    
    /// The path of the output  json file
    public let outputFile: String?

    enum CodingKeys: String, CodingKey {
        case disabledRules = "disabled_rules"
        case reporter
        case indexStorePath = "index_store_path"
        case included
        case excluded
        case excludedGroupName = "excluded_group_name"
        case blacklistFiles = "blacklist_files"
        case blacklistSymbols = "blacklist_symbols"
        case blacklistSuperClass = "blacklist_superclass"
        case outputFile = "output_file"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.disabledRules = try container.decodeIfPresent([RuleType].self, forKey: .disabledRules)
        self.reporter = try container.decodeIfPresent(ReporterType.self, forKey: .reporter)
        self.indexStorePath = try container.decodeIfPresent(String.self, forKey: .indexStorePath)
        self.included = try container.decodeIfPresent([String].self, forKey: .included)
        self.excluded = try container.decodeIfPresent([String].self, forKey: .excluded)
        self.excludedGroupName = try container.decodeIfPresent([String].self, forKey: .excludedGroupName)
        self.blacklistFiles = try container.decodeIfPresent([String].self, forKey: .blacklistFiles)
        self.blacklistSymbols = try container.decodeIfPresent([String].self, forKey: .blacklistSymbols)
        self.blacklistSuperClass = try container.decodeIfPresent([String].self, forKey: .blacklistSuperClass)
        self.outputFile = try container.decodeIfPresent(String.self, forKey: .outputFile)
    }
}

extension YamlConfiguration: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(disabledRules)
        hasher.combine(reporter)
        hasher.combine(indexStorePath)
        hasher.combine(included)
        hasher.combine(excluded)
        hasher.combine(excludedGroupName)
        hasher.combine(blacklistFiles)
        hasher.combine(blacklistSymbols)
        hasher.combine(blacklistSuperClass)
        hasher.combine(outputFile)
    }
    
    public static func == (lhs: YamlConfiguration, rhs: YamlConfiguration) -> Bool {
        return (lhs.disabledRules == rhs.disabledRules) &&
            (lhs.reporter == rhs.reporter) &&
            (lhs.indexStorePath == rhs.indexStorePath) &&
            (lhs.included == rhs.included) &&
            (lhs.excluded == rhs.excluded) &&
            (lhs.excludedGroupName == rhs.excludedGroupName) &&
            (lhs.blacklistFiles == rhs.blacklistFiles) &&
            (lhs.blacklistSymbols == rhs.blacklistSymbols) &&
            (lhs.blacklistSuperClass == rhs.blacklistSuperClass) &&
            (lhs.outputFile == rhs.outputFile)
    }
}
