<!-- PROJECT LOGO -->
<br />
<p align="center">
  <h3 align="center">The Get a Band Project</h3>
</p>


<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li><a href="#user-journey">User journey</a></li>
    <li><a href="#main-features">Main features</a></li>    
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

Get a Band is a platform connecting engaged couples planning their wedding with musicians, bands and DJs eager to play for their big day. Find the app in production on Heroku [here](https://get-a-band.herokuapp.com/)

Welcome to the Get A Band Platform!

### Built With

#### Languages and frameworks
* [Ruby - ver. 2.7.1](https://ruby-doc.org/core-2.7.1/)
* [Ruby on Rails - ver. 5.2.4](https://rubyonrails.org/)
* [JavaScript](https://www.ecma-international.org/publications-and-standards/standards/ecma-262/)
* [Bootstrap](https://getbootstrap.com)

#### PostGreSQL database


#### Front-end
Design of the graphic identity of the brand (colors, typographies...) and adaptation of a CSS overlay (UI Kit Bootstrap) according to it. Development of Javascript scripts for the animation of the site, in particular for the animation of the search filters.

#### Back-end
Fundamentals : Ruby and Ruby on Rails, Devise identification gem, Stripe API, Forest Admin interface, basic artist filtering system by event date.
Bonus : embedded Spotify player to integrate music on the artists' profiles, implementation of a review system, implementation of a private message chat feature, pagination of available artists, advanced filtering system by artist categories (with several options) and location choice.
##### Ruby Gems, APIs, and other tools
* [Font Awesome](https://fontawesome.com)
* [Stripe](https://stripe.com/fr) and the [Stripe Gem](https://github.com/stripe/stripe-ruby)
* [MailJet](https://fr.mailjet.com/) 
* [Devise Gem](https://github.com/heartcombo/devise)
* [Faker Gem](https://github.com/faker-ruby/faker)
* [Pagy Gem](https://github.com/ddnexus/pagy)
* [ForestAdmin] (https://www.forestadmin.com/)


<!-- USER JOURNEY -->
## User Journey
### On the artists' side
The artist creates an account with an e-mail and password, then fills in their profile, which will include essential information such as
* Their artistic name
* A short description of their artistic approach, including the music genre they offer and examples of tracks or references
* Their hourly rate

Their profile gets enriched afterwards as customers leave reviews on the platform. The artist's profile also displays an availability calendar that is updated according to the bookings.
The artist can follow their past and future reservations on their administrator interface. When a bride & groom make a reservation request, the artist is informed and must validate or refuse the pending reservation from their interface.

### On the groom and bride's side
The bride and groom create an account with an email and password, then are invited to fill out a questionnaire about their needs (date and place of the wedding, what style of music they are looking for, for what part of the day...). The results of their artist search are filtered accordingly. They choose an artist that interests them and can directly send a booking request, with payment of a deposit.
Once the booking is complete, the bride and groom can leave a review and a note on the artist's performance, which will then appear on their profile.

<!-- MAIN FEATURES -->
## Main Features
### For all
### For registered users
### For registered artists
### Other
* There is an admin platform, managed through the ForestAdmin API. The website's admin manually approves each artist who signs up. Artists are not visible on the public artist index page until they have been approved by the admin. The admin approves artists who have completed their profile with legitimate information (i.e. a real description).

<!-- CONTACT -->
## Contributors listed in alphabetical order
* [Ariane](https://github.com/arejl)
* [Arnaud](https://github.com/JAG-ROSA/)
* [Caroline](https://github.com/Caro407)
* [Martin](https://github.com/Martinfzz)