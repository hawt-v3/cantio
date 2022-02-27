import firebase from "../firebase";
export const checkIfRegistered = async key => {
  const user = await firebase.firestore().collection("users").doc(key).get();

  if (!user.exists) {
    return null;
  }

  return await user.data();
};

export const intiializeUser = async key =>
  await firebase
    .firestore()
    .collection("users")
    .doc(key)
    .set({ init: false, profilePic: `https://robohash.org/${key}` });
