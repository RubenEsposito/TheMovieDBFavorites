//
//  WorkItem.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

final class WorkItem {
    
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    func perform(after: TimeInterval, _ block: @escaping () -> Void) {
        /// Cancel the currently pending item
        pendingRequestWorkItem?.cancel()
        
        /// Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem(block: block)
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: requestWorkItem)
    }
}
