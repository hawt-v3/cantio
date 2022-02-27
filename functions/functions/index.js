const functions = require("firebase-functions");
const admin = require("firebase-admin");

const serviceAccount = require("./firekey.json");

function shuffle(array) {
  let currentIndex = array.length,
    randomIndex;

  while (currentIndex != 0) {
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;

    [array[currentIndex], array[randomIndex]] = [
      array[randomIndex],
      array[currentIndex],
    ];
  }

  return array;
}

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

exports.feed = functions.https.onRequest(async (request, response) => {
  const userId = request.query.uid;

  const user = await admin.firestore().collection("users").doc(userId).get();
  const totalLiked = user.totalLiked;
  const likedSongs = await admin
    .firestore()
    .collection("users")
    .doc(userId)
    .collection("likedSongs")
    .get();

  // do the genres with the music

  let genreArray = [];
  for (let song in likedSongs.docs) {
    genreArray.push(likedSongs.docs[song].data().genre);
  }

  let genreCount = {};

  for (let i = 0; i < genreArray.length; i++) {
    let num = genreArray[i];
    genreCount[num] = (genreCount[num] || 0) + 1;
  }

  let genreCountArray = [];

  for (let genre in genreCount) {
    genreCountArray.push({
      genre: genre,
      count: (genreCount[genre] / totalLiked) * 20,
    });
  }

  let songs = genreCountArray.map(song => {
    let songs = await admin
      .firestore()
      .collection("songs")
      .where("genre", "==", song.genre)
      .limit(song.count)
      .get();
    songs = songs.docs.map(song => song.data());
    return songs;
  });

  songs = shuffle(songs);

  let artists = await admin.firestore().collection("users").get();
  artists = shuffle(artists)
    .slice(0, 6)
    .map(artist => artist.data());

  response.json({ songs, artists });
});
