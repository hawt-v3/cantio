import firebase from "firebase";

const firebaseConfig = {
  apiKey: "AIzaSyCRKw6cPNFVrL0qv30K481Cy2Tl2_rdUDk",
  authDomain: "cantio-3450d.firebaseapp.com",
  projectId: "cantio-3450d",
  storageBucket: "cantio-3450d.appspot.com",
  messagingSenderId: "710677582027",
  appId: "1:710677582027:web:6dd10cf1a463d0f9494b4e",
};

// Initialize Firebase
const app = firebase.initializeApp(firebaseConfig);
export default app;
