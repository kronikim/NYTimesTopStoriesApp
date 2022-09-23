# NYTimesTopStoriesApp
New York Times Top Stories App

Note : Development branch is "dev"

"New York Times Top Stories" app is using Swift designed by MVVM structure with a different approach. Passing View Model to View Controller is mandatory in this approach.

Please find the details about the app below.

-  Minimum deployment target is IOS 12.0

-  Latest version of Swift is used ( Swift 5.7, Xcode 14.0.1, IOS 16 )

-  App works in portrait and landscape orientations

-  App contains Splash, Top Story list page and pages for the Details of each story. 

-  Splash page shows the name and logo of the App

-  App starts with a list of stories for the default category. "Top Story List" shows possible categories with a "CategoryMenuBar" at the top of the page by using "collectionView". When a new category is selected, tableview reloads with the data from the selected category. It shows the list of the stories with their image, title and author information.

-  Top Story Detail View page contains a larger image, story title, published date, description, author information and a "See More" button to preview the article. Detail pages support Safari extension for the full story (by opening a url without leaving the app)

API is from https://developer.nytimes.com which works with a unique API key. Please first get your unique API Key from the web site and set that APIKey into the parameters (type of [URLQueryItem] ) of the NYTTopStoriesEndpoint file. 
 
Link to the Top Stories API guide : https://developer.nytimes.com/docs/top-stories-product/1/overview 
 
Link to the JSON model : https://developer.nytimes.com/docs/top-stories-product/1/types/Article

<img width="358" alt="splashPage" src="https://user-images.githubusercontent.com/29311417/191979821-b21fc9f7-9e74-4f59-a4c6-d2b8f21dccf9.png">
<img width="362" alt="listPage" src="https://user-images.githubusercontent.com/29311417/191979838-8f547b45-9c2e-43fe-b027-ac3f02d001ff.png">
<img width="357" alt="image" src="https://user-images.githubusercontent.com/29311417/191978611-4c22685e-bb1c-4a78-ae41-6be86c13ed87.png">
<img width="728" alt="image" src="https://user-images.githubusercontent.com/29311417/191978517-38b19122-cf3f-408c-8aeb-b56f84efc16e.png">
<img width="171" alt="pressedSeeMore" src="https://user-images.githubusercontent.com/29311417/191980424-04bcb55c-1439-4121-8d2c-98706b087ab1.png">
