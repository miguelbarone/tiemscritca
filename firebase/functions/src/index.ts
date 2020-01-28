import * as functions from 'firebase-functions';
import * as express from 'express'
import * as admin from 'firebase-admin'

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript

const items = [
    {
        "name": "Mizael",
        "age": 19
    },
    {
        "name": "Tinoco",
        "age": 15
    },
    {
        "name": "Nina",
        "age": 19
    },
    {
        "name": "Jean",
        "age": 19
    },
    {
        "name": "Marlon",
        "age": 28
    },
]

var app = express();

app.get('/people', function (request, response) {
    response.json(items);
});

app.post('/register', async function (request, response) {
    let email = request.body.email
    let password = request.body.password

    var firebase = admin.initializeApp()

    var user = await firebase.auth().createUser({
        email: email,
        password: password,
    })

    var token = await firebase.auth().createCustomToken(user.uid)

    response.json({
        jwt: token
    })
});

exports.api = functions.https.onRequest(app);

// export const people = functions.https.onRequest((request, response) => {
//     console.log(`route: ${request.route}`)
//     response.json(items);
// });

// export const newRoute = functions.https.onRequest((request, response) => {
//     response.json({
//         route: request.path,
//         method: request.method
//     });
// });

