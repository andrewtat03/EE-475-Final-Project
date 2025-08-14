/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.alertOnThreshold = functions.firestore
    .document("stickers/{docId}")
    .onUpdate((change, context) => {
      const newData = change.after.data();

      const temperature = newData.temperature;
      const humidity = newData.humidity;
      const light = newData.light;

      const threshold = {
        temperature: 85,
        humidity: 90,
        light: 3000,
      };

      let alert = "";

      if (temperature > threshold.temperature) {
        alert += `Temperature is high: ${temperature}°F\n`;
      }
      if (humidity > threshold.humidity) {
        alert += `Humidity is high: ${humidity}%\n`;
      }
      if (light > threshold.light) {
        alert += `Light level is high: ${light} lx\n`;
      }

      if (alert) {
        return admin.messaging().sendToTopic("alerts", {
          notification: {
            title: "Smart Sticker Alert",
            body: alert.trim(),
          },
        });
      }

      return null;
    });
