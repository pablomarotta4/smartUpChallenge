Copycat Twitter by Pablo Marotta

In this project, I used Flutter and Firebase, which I had never used before, so developing this test was quite a challenge for me. I chose Firebase as the backend for this project because of its simple and efficient integration. With Firebase, I can handle user authentication securely using multiple methods like email and Google. The real-time databases (Firestore) allow me to synchronize data efficiently.

In the project, you will find: a welcome page where you can choose to log in with your Google account, register, or log in. These three functionalities are active and available. Within the registration, you can do it with an email but not with a phone number, and the login can be done with email and username (which is generated using the name entered during registration and the user creation date in the format yyyymmdd). Phone registration was excluded because I couldn't implement Firebase to send the SMS code to the respective users, but it works with the test user provided in the database. I considered that its implementation was not as relevant for the project. Once logged in and on the home page, you can see all the tweets generated by all users and create your own tweet. The stories are hardcoded and feature fictional users.
