# shared-closet
This is an app that allows users to upload pictures and profiles of their wardrobe in order to coordinate borrowing clothing from other users.

The minimum viable version of this app will allow user creation and login, clothing profile uploads(initially title, description, single image), and messaging to facilitate in-app communication between users.

In the future, I hope to add user groups, image galleries for clothing, message updates through push notifications, watchlist, push notifications for watchlist items that are marked as being available. There will also be some form of reporting and blocking, and potentially a user rating system. I may also add in a more structured way of borrowing items through the app instead of leaving it relatively open ended through the chat system. I also plan on adding sharing options, multi point login(facebook, maybe twitter and instagram?). 

I plan on adding additional descriptors and tags for clothing items. Some will be more structured like color, type, condition. The tags themselves will be freeform, and maybe include some form of autocomplete for popular tags? The Search tab will include a filter and search tab bar option to actually find what the user wants. 

I am utilizing a Parse backend hosted on Heroku to offset the majority of the server workload to queries and object creation + updates within the client. I am using JSQMessagesViewController for an out of the box chatting solution as I've used it in the past without much issue outside of customization difficulties. 
