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

![](https://user-images.githubusercontent.com/29311417/191975312-8aecbe0d-f4d7-4de6-8d18-2368ef92312d.png)


![](https://user-images.githubusercontent.com/29311417/191975336-281aa011-9775-4e95-9c62-fc1cad88f8ed.png)

![](https://user-images.githubusercontent.com/29311417/191975348-89aef44a-1936-447a-8d6d-815ab3473e11.png)

![](https://user-images.githubusercontent.com/29311417/191975362-537d72e5-045d-43e7-acf3-a7328cb28e9b.png)
