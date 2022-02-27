import firebase from "../firebase";
export const checkIfRegistered = async key => {
  const user = await firebase.firestore().collection("users").doc(key).get();

  if (!user.exists) {
    return null;
  }

  let likedSongs = await firebase
    .firestore()
    .collection("users")
    .doc(key)
    .collection("likedSongs")
    .get();

  likedSongs = likedSongs.docs.map(doc => ({
    ...doc.data(),
    id: doc.id,
  }));

  let follows = await firebase
    .firestore()
    .collection("users")
    .doc(key)
    .collection("following")
    .get();

  follows = follows.docs.map(doc => ({
    ...doc.data(),
    id: doc.id,
  }));
  console.log(follows);

  return { ...user.data(), likedSongs, follows };
};

export const intiializeUser = async key =>
  await firebase
    .firestore()
    .collection("users")
    .doc(key)
    .set({ init: false, key, profilePic: `https://robohash.org/${key}` });
