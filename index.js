// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

(function () {
  // <code>
  "use strict";
  require('dotenv').config()

  // pull in the required packages.
  var sdk = require("microsoft-cognitiveservices-speech-sdk");
  var readline = require("readline");
  var fs = require("fs");

  // replace with your own subscription key,
  // service region (e.g., "westus"), and
  // the name of the file you save the synthesized audio.
  var subscriptionKey = process.env.SUBSCRIPTION_KEY;
  var serviceRegion = "eastus"; // e.g., "westus"
  var filename = "YourAudioFile.wav";

  // we are done with the setup

  // now create the audio-config pointing to our stream and
  // the speech config specifying the language.
  var audioConfig = sdk.AudioConfig.fromAudioFileOutput(filename);
  var speechConfig = sdk.SpeechConfig.fromSubscription(
    subscriptionKey,
    serviceRegion
  );

  speechConfig.speechSynthesisLanguage = "de-DE";
  speechConfig.speechSynthesisVoiceName = "de-DE-KatjaNeural";

  // create the speech synthesizer.
  var synthesizer = new sdk.SpeechSynthesizer(speechConfig, audioConfig);

  var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  function xmlToString(filePath) {
    const xml = fs.readFileSync(filePath, "utf8");
    return xml;
  }
  const ssml = xmlToString("ssml.xml");

  rl.close();
  // start the synthesizer and wait for a result.
  synthesizer.speakSsmlAsync(
    ssml,
    function (result) {
      if (result.reason === sdk.ResultReason.SynthesizingAudioCompleted) {
        console.log("synthesis finished.");
      } else {
        console.error(
          "Speech synthesis canceled, " +
            result.errorDetails +
            "\nDid you update the subscription info?"
        );
      }
      synthesizer.close();
      synthesizer = undefined;
    },
    function (err) {
      console.trace("err - " + err);
      synthesizer.close();
      synthesizer = undefined;
    }
  );
  console.log("Now synthesizing to: " + filename);
  // </code>
})();
