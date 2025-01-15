//
//  ContentView.swift
//  LightJournal
//
//  Created by Chuci Chen on 1/14/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var journals: [JournalEntry]
    @State private var showingNewEntry = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Today's Dialogue Button
                NavigationLink(destination: DialogueView(entry: todaysEntry)) {
                    JournalButton(
                        title: "Today's Dialogue",
                        systemImage: "bubble.left.and.bubble.right",
                        color: .blue
                    )
                }
                
                // Past Journals Button
                NavigationLink(destination: PastJournalsView()) {
                    JournalButton(
                        title: "Past Journals",
                        systemImage: "book.closed",
                        color: .purple
                    )
                }
                
                // New Entry Button
                Button {
                    let _ = createNewEntry()
                    showingNewEntry = true
                } label: {
                    JournalButton(
                        title: "New Entry",
                        systemImage: "plus.circle",
                        color: .green
                    )
                }
            }
            .padding()
            .navigationTitle("LightJournal")
            .navigationDestination(isPresented: $showingNewEntry) {
                if let lastEntry = journals.last {
                    DialogueView(entry: lastEntry)
                }
            }
        }
    }
    
    private var todaysEntry: JournalEntry {
        let calendar = Calendar.current
        let today = journals.first { calendar.isDate($0.timestamp, inSameDayAs: Date()) }
        return today ?? createNewEntry()
    }
    
    private func createNewEntry() -> JournalEntry {
        let entry = JournalEntry()
        modelContext.insert(entry)
        return entry
    }
}

struct JournalButton: View {
    let title: String
    let systemImage: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .font(.title2)
            Text(title)
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption)
        }
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(color.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
