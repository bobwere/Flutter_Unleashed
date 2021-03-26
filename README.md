# Flutter Unleashed
App to allow user to create a profile, manage todos, browse and favourite pokemons

## Link
https://drive.google.com/file/d/1MnHStnmKfy4G7Vx8pZA7alAYJrNbiPta/view?usp=sharing

## Design
link to wireframes used to conceptualize app design

## Features
 * create user profile
 * edit user profile
 * delete user profile
 * info page the form autovalidates to allow user to correct errors before submission
 * fetch todos from jsonplaceholder api
 * able to filter fetched todos by status (incomplete or completed)
 * a profile page with qoute of the day animation
 * able to view your favourite pokemons and delete as you will
 * the dictionary page able to view all pokemons which is an unsorted dictionary
 * able to filter the dictionary by alpha key or numeric key entries
 * able to add to favourites
 * smooth silk animations and transitions
 
## State Management
 * used bloc pattern to manage creating profile, editing profile and deleting profile
   across both info tab and design tab
 * used bloc pattern to manage the dictionary state that is (unsorted,sorted by numeric key or sorted by alpha key)
   and also manage current users favourite pokemons
 * for the response page employed local state (setstate) to manage api locals since its only consumed by the response page only
 
 
 
