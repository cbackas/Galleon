// Created for Galleon in 2021
// Using Swift 5.0

import Foundation

extension ViewModel {
    // calculate the number of pages for the paginator
    func updateHistoryTotalPages() {
        let totalRecords = self.visibleHistory?.totalRecords ?? 1
        let pageSize = self.visibleHistory?.pageSize ?? 1
        var pages = totalRecords / pageSize
        // if theres any remainders they'd go on an extra page
        pages += (totalRecords % pageSize) >= 1 ? 1 : 0
        self.totalHistoryPages = pages
    }
    
    func updateHistory(_ useIndicator: Bool = false) {
        // show visual loading indicator??
        self.historyLoaded = !useIndicator
        
        // load cached data first
        // if none found just keep showing the existing page until API update completes
        self.visibleHistory = self.historyData.first {
            $0.page == self.selectedHistoryPage
        } ?? self.visibleHistory
        
        // make sure total pages is as updated as it can be
        self.updateHistoryTotalPages()
        
        // try to update from API
        SonarrComm.shared.getHistory(page: self.selectedHistoryPage) {
            history, errorDescription in
            if (errorDescription != nil) {
                print("lol error: \(errorDescription!)")
            } else {
                // update items user can see
                self.visibleHistory = history!
                
                // make sure total pages is as updated as it can be
                self.updateHistoryTotalPages()
                
                // update cached history data
                self.historyData.removeAll() {
                    $0.page == self.selectedHistoryPage
                }
                self.historyData.append(history!)
                
                // make sure loading indicator isn't showing anymore
                self.historyLoaded = true
            }
        }
    }
}
