import SwiftUI
import FirebaseDatabase
import Combine

struct UserScore: Identifiable {
    let id: String  // UUID
    let score: Int
}

class ScoresViewModel: ObservableObject {
    @Published var scores = [UserScore]()

    private var ref: DatabaseReference = Database.database().reference()
    private var databaseHandle: DatabaseHandle?

    init() {
        fetchScores()
    }

    func fetchScores() {
        databaseHandle = ref.child("users").observe(.value, with: { snapshot in
            var newScores = [UserScore]()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let value = snapshot.value as? [String: Any],
                   let score = value["score"] as? Int {
                    let userScore = UserScore(id: snapshot.key, score: score)
                    newScores.append(userScore)
                }
            }
            DispatchQueue.main.async {
                self.scores = newScores
            }
        })
    }

    deinit {
        if let databaseHandle = databaseHandle {
            ref.removeObserver(withHandle: databaseHandle)
        }
    }
}

struct ScoresView: View {
    @ObservedObject var viewModel = ScoresViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.scores) { userScore in
                HStack {
                    Text(userScore.id)
                    Spacer()
                    Text("\(userScore.score)")
                }
            }
            .navigationBarTitle("Scores")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        ScoresView()
    }
}
