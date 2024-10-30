importScripts(
  "https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js"
);
importScripts(
  "https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyBpFyYO3FrJM1sf_rdSuJMvPxgD5zo4T9Y",
  appId: "1:321544719651:web:501a92df185514195f9096",
  messagingSenderId: "321544719651",
  projectId: "church-control-28e53",
  authDomain: "church-control-28e53.firebaseapp.com",
  storageBucket: "church-control-28e53.appspot.com",
  measurementId: "G-YN85BMCE9T",
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});
