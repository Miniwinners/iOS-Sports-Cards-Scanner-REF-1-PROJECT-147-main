import Foundation
import UserNotifications

final class PushNotificationService {
    @discardableResult
    func requestUNPermission() async throws -> Bool {
        let center = UNUserNotificationCenter.current()
        let isAuthorized = try await center.requestAuthorization(options: [.alert, .sound, .badge])
        return isAuthorized
    }
}
