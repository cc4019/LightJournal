import SwiftUI
import SwiftData

struct PastJournalsView: View {
    @Query(sort: \JournalEntry.timestamp, order: .reverse) private var journals: [JournalEntry]
    @State private var searchText = ""
    
    var filteredJournals: [JournalEntry] {
        if searchText.isEmpty {
            return journals
        }
        return journals.filter { journal in
            journal.messages.contains { message in
                message.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredJournals, id: \.id) { journal in
                NavigationLink(destination: DialogueView(entry: journal)) {
                    JournalRow(journal: journal)
                }
            }
        }
        .navigationTitle("Past Journals")
        .searchable(text: $searchText, prompt: "Search journals...")
        .toolbar {
            Menu {
                Button(action: exportToPDF) {
                    Label("Export to PDF", systemImage: "arrow.up.doc")
                }
                Button(action: shareJournals) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
        }
    }
    
    private func exportToPDF() {
        // Implement PDF export
    }
    
    private func shareJournals() {
        // Implement sharing functionality
    }
}

struct JournalRow: View {
    let journal: JournalEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(journal.timestamp, style: .date)
                    .font(.headline)
                Spacer()
                if journal.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            
            if let summary = journal.summary {
                Text(summary)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            HStack {
                Label("\(journal.messages.count) messages", systemImage: "bubble.left")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if journal.messages.contains(where: { $0.type == .image }) {
                    Image(systemName: "photo")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                if journal.messages.contains(where: { $0.type == .voice }) {
                    Image(systemName: "mic")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        PastJournalsView()
    }
    .modelContainer(for: JournalEntry.self, inMemory: true)
} 