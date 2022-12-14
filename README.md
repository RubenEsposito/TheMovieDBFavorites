# Wembley - TheMovieDBFavorites

<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<h3 align="center">Wembley - TheMovieDB</h3>

  <p align="center">
    Example app showing MovieDB results using VIPER architecture.
    <br />
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#tests">Tests</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#decisions-log">Decisions Log</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This project is an exercise for the interview process at Wembley Studios. The aim of this code is to show my personal expertise on several aspects of iOS development.

Exercise instructions:

We need to create an app so that our employees can manage their favorite movies. ???? For this we will use the public API of The Movie DB (https://developers.themoviedb.org/3/getting-started/introduction).
  
The application must have a VIPER architecture and a main screen with two tabs. In the first tab we will show the user a list of popular movies (https://developers.themoviedb.org/3/movies/get-popular-movies)

In addition to a SearchBar in case we want to do a custom search. (https://developers.themoviedb.org/3/search/search-movies).

Each movie will also have the option to mark as a favorite. Therefore, in the second Tab, the user will be able to view the list of movies that have been marked as favorites.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps:

### Prerequisites

- Xcode 14.0
- Swift 5.7

### Installation

The project is prepared so everything you need to do is clone the repository, open the xcodeproj and run it.

IMPORTANT: Sometimes you could receive an error due to Swift Package Manager issues (typically a "Couldn't get revision" error). If it happens to you, please in Xcode click File > Packages -> Reset Package Caches from the menu and then build again.

### Tests

You can run the unit tests with Cmd + U.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

On the starting screen you will see the information from the popular movies. If you tap on the search bar and write some word, it will show related movies found. If you tap on the favorite button on a movie, it will be added to the favorites list. You can see the favorites movies in the Favorite Movies tab.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- DECISIONS LOG -->
## Decisions Log

*By following the commits you can see the changes implied

- It was asked to use VIPER architecture. I decided to separate entities in a different group, as they are shared. I created a Networking group to contain the services and managers as well to keep networking logic isolated from the modules.
- I created a Tab Bar also as a VIPER module.
- I create modules for the list of popular movies, the list of favorites, the detail view of the movie and the list of search results.
- The communication is done through the routers and the VIPER layers are clearly and respectfully separated by using protocols as the interface between them.
- Unit tests are added for all the cases.


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the GNU General Public License v3.0. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Rub??n Exp??sito Mar??n - ruben@lightonapps.com

Project Link: [https://github.com/RubenEsposito/TheMovieDBFavorites](https://github.com/RubenEsposito/TheMovieDBFavorites)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/RubenEsposito/TheMovieDBFavorites.svg?style=for-the-badge
[contributors-url]: https://github.com/RubenEsposito/TheMovieDBFavorites/graphs/contributors
[license-shield]: https://img.shields.io/github/license/RubenEsposito/TheMovieDBFavorites.svg?style=for-the-badge
[license-url]: https://github.com/RubenEsposito/TheMovieDBFavorites/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/rubenexposito
