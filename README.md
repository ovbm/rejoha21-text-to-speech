# Text-To-Speech Experiments for Rethink Journalism Hackathon 2021

## Goals
- Transforms HTML to SSML
- Uses the Mircosoft Speech SDK for JavaScript on Node.js. 

## Prerequisits
* A subscription key for the Speech service. See [Try the speech service for free](https://docs.microsoft.com/azure/cognitive-services/speech-service/get-started).
* A [Node.js](https://nodejs.org) compatible device.

## Prepare the sample

* run `npm install` to install the dependencies.
* Copy `.env.example`to `.env`and add the Azure `SubscriptionKey`.

## Run the sample
* Add your text into ssml.xml
* Run `node index.js`

This will create a file named `YourAudioFile.wav`in the folder.

## References
* [Speech SDK API reference for JavaScript](https://aka.ms/csspeech/javascriptref)
