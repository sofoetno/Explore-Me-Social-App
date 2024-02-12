# Explore Me Social Networking App

- [Explore Me Social Networking App](#explore-me-social-networking-app)

  - [What is explore-me?](#what-is-explore-me)
  - [Features overview](#features-overview)
  - [Frameworks & Services](#frameworks-and-services)
    - [Users](#users)
    - [Posts](#posts)
    - [Comments](#comments)
    - [Likes](#likes)
    - [Followers](#followers)
  - [Code organization](#code-organization)
  - [Features in details](#features-in-details)
  - [Navigation system](#navigation-system)
  - [Handling images](#handling-images)

## What is explore-me?

**explore-me** is a social network for people with common interests who have special skills at the amateur or professional level. **explore-me** allows us to discover ourselves and others through storytelling posts.

## Features overview

- Explore user generated posts
- Manage your posts
- Connect with others by chat
- Comment explored posts
- Like posts
- Follow explored person
- Explore user profiles
- Manage your profile

## Frameworks and Services:

- UIKit
- SwiftUI
- PhotoKit
- Firebase
  - Authentication
  - Firestore (Database)
  - Storage (fot storing files)

### Firestore (Database) Collections

#### users

- full_name
- email
- image_url
- date_created

#### posts

- title
- description
- photo_url
- user_id
- date_created

#### comments

- text
- post_id
- user_id
- date_created

#### likes

- post_id
- user_id

#### followers

- follower_id
- following_id

#### chats

- participants

#### messages

- text
- chat_id
- sender_id
- send_date

### Relationship Between Collections

![dbdiagram](dbdiagram.png "Database Diagram")

## Code organization

- Manager Classes - to communicate with backend, sending and receiving data (plain Swift)
- Model Structs - representing data (plain Swift)
- ViewModel Classes - connecting managers and models with views (SwiftUI)
- Views: Scenes & Components - representing user UI, visualizing data (SwiftUI)
- Navigation system (UIKit: UINavigationController, UITabBarController)
- Tables and Collections (UIKit: UITableViewController, UICollectionViewController)
- Project Base (UIKit: AppDelegate, SceneDelegate)

## Navigation system

Two UIKit view controllers are used for navigation: **UINavigationController** and **UITabBarController**.

- For unauthorized user pages (onboarding, login, register) **AuthNavigationController** (child class of **UINavigationController**) is used.
- For an authorized user (feed, chat, profile...) the root controller is **TabViewController** (child class of **UITabBarController**).
  - Each tab of **TabViewController** is, in turn, an instance of **UINavigationController**.
- When the application opens, the **SceneDelegate** decides which view controller should be the root view controller.
  - If the user is authenticated, then the **TabViewController** becomes the root view controller.
  - If the user is not authenticated, then the **AuthNavigationController** becomes the root view controller.
- Transition from one View to another is done through the **WithRootNavigationController** protocol and its extension.
  - The **WithRootNavigationController** protocol extension adds methods and properties to all Views that conform to the **WithRootNavigationController** protocol (`extension WithRootNavigationController where Self:View { ... }`).
  - Each View from which another View is navigated must conform to the **WithRootNavigationController** protocol to add navigation methods and properties that come from the **WithRootNavigationController** protocol extension (push, pop, present, dismiss, authNavigationController).
  - Views intended for unauthorized users use the **authNavigationController** property and call methods such as pushViewController, popViewController, setViewControllers
  - Views intended for authorized users use direct push, pop, present, dismiss methods, which use those instances of **UINavigationController** for navigation, which instance is the main view controller of the corresponding tab of the calling View.

## Handling images

- **PHPicker** class from **PhotoKit** is used for letting users select images from their phones.
- Then custom **ImageManager** class sends selected image data to **Firebase Storage**.
- **Firebase Storage** service returns URL of saved image; this URL is then saved alongside corresponding document (either in posts or users collection).
- For getting images AsyncImage view is used (part of SwiftUI).
- **CustomAsyncImage** (extended custom version of **AsyncImage**) uses custom `ImageCache.images` static property dictionary to cache those images in memory. If `images` dictionary already contains key with this URL, the image is retrieved from dictionary, if not, then AsyncImage tries to download it and cache (save in dictionary) before make it appear on screen.
