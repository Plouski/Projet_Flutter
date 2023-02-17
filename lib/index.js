// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import {getAuth} from "firebase/auth";
import {getFirestore} from 'firebase/firestore';

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyANTlf1d4fXG-4mtapejF7GqB2wp30oGiQ",
  authDomain: "fir-flutter-repairbike.firebaseapp.com",
  projectId: "fir-flutter-repairbike",
  storageBucket: "fir-flutter-repairbike.appspot.com",
  messagingSenderId: "396063305758",
  appId: "1:396063305758:web:21f82cf79c4a5bf04cbe0f",
  measurementId: "G-KH48Q8ZDM5"
};
const auth = getAuth(firebaseApp);
const db = getFirestore(firebaseApp);

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
