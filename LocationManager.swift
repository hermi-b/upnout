import SwiftUI

struct Player: Identifiable {
    let id = UUID()
    let rank: Int
    let name: String
    let score: Int
    let avatar: String
}

struct Leaderboard: View {
        @State private var players: [Player] = [
            Player(rank: 1, name: "MossWalker", score: 1500, avatar: "leaf.fill"),
            Player(rank: 2, name: "RiverFox", score: 1300, avatar: "hare.fill"),
            Player(rank: 3, name: "TreeSinger", score: 1200, avatar: "tortoise.fill"),
            Player(rank: 4, name: "StoneHopper", score: 1100, avatar: "ant.fill"),
            Player(rank: 5, name: "SunBloom", score: 1000, avatar: "sun.max.fill"),
            Player(rank: 6, name: "WindWhisper", score: 950, avatar: "wind"),
            Player(rank: 7, name: "PineShadow", score: 900, avatar: "cloud.fill"),
            Player(rank: 8, name: "BerryBear", score: 860, avatar: "pawprint.fill"),
            Player(rank: 9, name: "EchoOwl", score: 820, avatar: "eye.fill"),
            Player(rank: 10, name: "SkyRoot", score: 800, avatar: "cloud.sun.fill"),
            Player(rank: 11, name: "LakeSwan", score: 780, avatar: "drop.fill"),
            Player(rank: 12, name: "MeadowDeer", score: 750, avatar: "leaf.arrow.circlepath"),
            Player(rank: 13, name: "CricketStep", score: 720, avatar: "ant.circle.fill"),
            Player(rank: 14, name: "BloomFox", score: 690, avatar: "flame.fill"),
            Player(rank: 15, name: "FernGlow", score: 660, avatar: "sparkles"),
            Player(rank: 16, name: "StreamSong", score: 640, avatar: "music.note"),
            Player(rank: 17, name: "BlossomWolf", score: 620, avatar: "bolt.heart.fill"),
            Player(rank: 18, name: "PebblePath", score: 600, avatar: "globe.europe.africa.fill"),
            Player(rank: 19, name: "ThistleWing", score: 580, avatar: "bird.fill"),
            Player(rank: 20, name: "CedarGaze", score: 560, avatar: "eye.circle.fill")
        ]

    
    
    @State private var selectedPlayer: Player? = nil
    @Namespace private var animation

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.green.opacity(0.5), .blue.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("🌲 Leaderboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .green, radius: 10)

                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(players) { player in
                            LeaderboardRow(player: player)
                                .onTapGesture {
                                    selectedPlayer = player
                                }
                                .transition(.move(edge: .bottom))
                        }
                    }
                    .padding(.bottom, 30)
                }
                .refreshable {
                    await animateLeafDrop()
                    players.shuffle()
                }
            }
            .padding()

            if let player = selectedPlayer {
                PlayerProfileView(player: player, onClose: {
                    withAnimation { selectedPlayer = nil }
                })
                .transition(.scale)
                .zIndex(1)
            }
        }
    }
    
    func animateLeafDrop() async {
        // Simulate an animated leaf refresh (placeholder for real animation)
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
}

struct LeaderboardRow: View {
    let player: Player
    
    var medal: String? {
        switch player.rank {
        case 1: return "🥇"
        case 2: return "🥈"
        case 3: return "🥉"
        default: return nil
        }
    }
    
    var rowColor: Color {
        switch player.rank {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .white
        }
    }
    
    var body: some View {
        HStack {
            Text(medal ?? "#\(player.rank)")
                .font(.title2)
                .frame(width: 40)

            Image(systemName: player.avatar)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .foregroundColor(.green)
                .padding(6)
                .background(Circle().fill(Color.white.opacity(0.3)))

            Text(player.name)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading, 8)

            Spacer()

            Text("\(player.score)")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.green.opacity(0.3)))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(rowColor.opacity(0.8), lineWidth: 2)
        )
        .shadow(color: rowColor.opacity(0.5), radius: 5, x: 0, y: 3)
    }
}

struct PlayerProfileView: View {
    let player: Player
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: player.avatar)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.green)
                .padding()
                .background(Circle().fill(Color.white.opacity(0.4)))

            Text(player.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Score: \(player.score)")
                .font(.title3)
                .foregroundColor(.white)

            Button(action: onClose) {
                Text("Close")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.2))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.green.opacity(0.6)))
        .padding(40)
    }
}

#Preview {
    Leaderboard()
}

