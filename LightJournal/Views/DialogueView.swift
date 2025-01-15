import SwiftUI
import SwiftData

struct DialogueView: View {
    @Bindable var entry: JournalEntry
    @State private var newMessage: String = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(entry.messages, id: \.id) { message in
                    MessageRow(message: message)
                }
            }
            
            HStack {
                Button(action: addImage) {
                    Image(systemName: "photo")
                        .font(.title2)
                }
                
                Button(action: startVoiceRecording) {
                    Image(systemName: "mic")
                        .font(.title2)
                }
                
                TextField("Type your thoughts...", text: $newMessage)
                    .textFieldStyle(.roundedBorder)
                
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title2)
                }
            }
            .padding()
        }
        .navigationTitle("Today's Dialogue")
        .toolbar {
            Button("Finish Journal") {
                finishJournal()
            }
        }
    }
    
    private func sendMessage() {
        guard !newMessage.isEmpty else { return }
        let message = JournalMessage(
            id: UUID(),
            content: newMessage,
            type: .text,
            timestamp: Date()
        )
        entry.messages.append(message)
        newMessage = ""
    }
    
    private func addImage() {
        // Implement image picker
    }
    
    private func startVoiceRecording() {
        // Implement voice recording
    }
    
    private func finishJournal() {
        // Implement AI summarization
        entry.isCompleted = true
    }
}

struct MessageRow: View {
    let message: JournalMessage
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(message.content)
                .padding()
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            if let url = message.mediaURL {
                // Display image or voice message UI
            }
            
            Text(message.timestamp, style: .time)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
} 