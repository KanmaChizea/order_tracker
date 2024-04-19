# Setup guide

- Clone project
```
git clone https://github.com/KanmaChizea/order_tracker.git
```

- Create `.env` file and insert the following variables with their accurate values
```
GH_CLIENT_ID = 
GH_CLIENT_SECRET = 
GH_REDIRECT_URL = 
ABLY_KEY = 
```

- Get dependencies
```
flutter pub get
```

And you're good to go!

## Usage guide

- Run the application

- Create an account and sign in with any of the options. Once you're signed in, you'd be presented with a screen displaying an active order

- On your Ably dashboard, attach to channel name `orderStatus`

- Send messages to update the status of the order on your app. The message date should be sent in order as ORDER ACCEPTED, ORDER PICK UP IN PROGRESS, ORDER ON THE WAY TO CUSTOMER, ORDER ARRIVED, ORDER DELIVERED

## Test the application

- Appetize link [here](https://appetize.io/app/6qoyzh7n2n7us5auwb64dbmqay?device=pixel7&osVersion=13.0)

- Demo Video link [here](https://drive.google.com/file/d/1SHv56rsvyOX9mgoPZb22126HRq1gfjuh/view?usp=sharing)