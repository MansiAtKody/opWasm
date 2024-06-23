self.addEventListener("notificationclick", function (event) {
  console.log("notification open");
  const data = event.notification.data.FCM_MSG.data;
  console.log('Data',data);

  event.waitUntil(
    clients.matchAll({
        type: "window",
      }).then(function (clientList) {

        if (clients.openWindow) {
            if(data.operatorUrl){
             if (data.module === "Notification") {
                 return clients.openWindow(`${data.operatorUrl}/home`);
             }
            }
        }
      })
  );
});

importScripts("https://www.gstatic.com/firebasejs/8.0.2/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.0.2/firebase-messaging.js");


var  firebaseConfig = {
         apiKey: "AIzaSyCtVNdV_9z3OgdesH6ZpDgCcmL7S1AaCZU",
         authDomain: "dasher-9a393.firebaseapp.com",
         projectId: "dasher-9a393",
         storageBucket: "dasher-9a393.appspot.com",
         messagingSenderId: "125348210814",
         appId: "1:125348210814:web:4867a51d80c31f1da5102f",
         measurementId: "G-VERSXCQPDS"
       };
firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();


