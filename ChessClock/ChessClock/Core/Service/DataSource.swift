import Foundation

protocol IDataSource: ObservableObject {
    var models: [TimeTry] { get }

    func remove(at offsets: IndexSet)
}

final class DataSource: IDataSource, ObservableObject {
    enum ModelsKeys: String {
        case savedModels
    }

    private let storage: any IStorage<ModelsKeys>

    @Published
    var models: [TimeTry]

    init(
        storage: any IStorage<ModelsKeys> = DefaultsStorage<ModelsKeys>()
    ) {
        self.storage = storage
        self.models = storage.retrieve(key: .savedModels) ?? []
    }

    func remove(at offsets: IndexSet) {
        models.remove(atOffsets: offsets)
        storage.save(
            models,
            key: .savedModels
        )
    }
}

// MARK: - IStopwatchDelegate
extension DataSource: IStopwatchDelegate {
    func didFinishCountingModel(_ model: TimeCountingModel) {
        models.append(model.asTimeTry)
        storage.save(
            models,
            key: .savedModels
        )
    }
}

// MARK: - Converting
private extension TimeCountingModel {
    var asTimeTry: TimeTry {
        TimeTry(id: id, startDate: startDate, intervals: intervals)
    }
}
