importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyCQUdBe3OGQ5jjcKpIJ51BAP0OWu5U5sTQ",
    appId: "1:694386983691:web:139196b60165894331580e",
    messagingSenderId: "694386983691",
    projectId: "dev-meetups-47f24",
    authDomain: "dev-meetups-47f24.firebaseapp.com",
    storageBucket: "dev-meetups-47f24.appspot.com",
    measurementId: "G-426WWWEHH3"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});