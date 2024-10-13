resource "spotify_playlist" "Rock" {
    name = "Rock"
    tracks = ["7k3jpyYPnVnbO0p7iejWxL", "6fABlNfAOylt7ZxfX8K1XL"]
}

data "spotify_search_track" "badshah" {
    artist = "Badshah"
}

resource "spotify_playlist" "Playlist" {
    name = "Party SOngs"
    description = "This playlist created by SHreyash using terraform"
    tracks = [ 
        data.spotify_search_track.badshah.tracks[1].id,
        data.spotify_search_track.badshah.tracks[5].id, 
        data.spotify_search_track.badshah.tracks[4].id 
    ]
}