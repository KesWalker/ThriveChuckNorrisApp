# thrive_chuck_norris_kw

A Chuck Norris App for Thrive, made by Kes Walker.


# build the app
-	please load the project into Android Studio
-	assuming you have flutter installed, type 'flutter pub get' into the terminal, making sure you are in the project directory
-	plug in an Android device
-	press the play button in Android Studio

# design
My first instinct when creating the project was to use a MVVM architecture but because I am slightly unfamiliar with Flutter, I decided to keep it simple and scrap the ViewModel part. So, the app is made up of 3 sections:
-	The model where the data is defined & the JSON mapper function lives.
-	The repo where the data is retrieved from a remote source.
-	The UI where the data is displayed.

👎 An optimal solution would have abstracted the code that interacts with the remote data source and put it into it’s own file. Injecting it into the repo when necessary. 

👍 But the repo allowed for a separation of concerns in relation to the UI layer, this enabled it to be easily unit tested and easily replaceable with an alternate data source like local storage.
