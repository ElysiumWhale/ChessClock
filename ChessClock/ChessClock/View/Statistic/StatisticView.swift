import SwiftUI

struct StatisticView<TDataSource: IDataSource, TSettings: ISettingsService>: View {
    @ObservedObject
    private var dataSource: TDataSource

    @ObservedObject
    private var settingsService: TSettings

    var body: some View {
        NavigationView {
            List {
                ForEach(dataSource.models) { model in
                    StatisticCellView(
                        model: model,
                        workColor: workColor,
                        restColor: restColor
                    )
                }
                .onDelete(perform: dataSource.remove)
            }
            .navigationTitle("Stats")
        }
    }

    init(dataSource: TDataSource, settingsService: TSettings) {
        self.dataSource = dataSource
        self.settingsService = settingsService
    }
}

private extension StatisticView {
    private var workColor: Binding<Color> {
        $settingsService.workColor
    }

    private var restColor: Binding<Color> {
        $settingsService.restColor
    }
}

struct StatisticView_Previews: PreviewProvider {
    static let manager: DataSource = {
        let dataSource = DataSource()

        dataSource.models.append(.init(
            id: UUID(),
            startDate: Date(),
            intervals: [
                .init(timeType: .work, minutes: 1),
                .init(timeType: .rest, seconds: 20),
                .init(timeType: .work, seconds: 38)
            ]
        ))
        
        dataSource.models.append(.init(
            id: UUID(),
            startDate: Date(),
            intervals: [
                .init(timeType: .work, minutes: 11),
                .init(timeType: .rest, seconds: 22),
                .init(timeType: .work, onlySeconds: 333)
            ]
        ))

        return dataSource
    }()

    static var previews: some View {
        StatisticView(
            dataSource: manager,
            settingsService: SettingsService()
        )
    }
}
