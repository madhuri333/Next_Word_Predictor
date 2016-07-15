Next Word Predictor App
========================================================
author: Madhuri Gupta
date: July 17, 2016
autosize: true
font-family: Cambria
transition: rotate

### Aim

To predict the next word corresponding to a word or phrase entered by user thereby providing quick and comfortable typing functionality.
  
  
About Us
========================================================
autosize: true
font-family: Cambria
transition: rotate

**NEXT WORD PREDICTOR** app helps the user type quickly by predicting the most frequently used word ensuing a word/phrase input by user.  
  
It has been developed as a part of **Data Science Specialization Capstone Project at Coursera**.  
  
This is my first take on Text Analytics and I have tried to explore and execute as permitted by time and resources. The app may not predict a word for every sentence but I have tried to train the model using diverse data sources like news, twitter and blogs to provide a next word prediction. It covers 65% of total dataset provided by Swift Key.  
  
Source code for the app - ui.R and server.R files are available on the [GitHub](https://github.com/madhuri333/Next_Word_Predictor).  
  
  
Approach & Algorithm
========================================================
autosize: true
font-family: Cambria
transition: rotate

Input phrase is cleaned first to bring it to n-grams format by converting to lower case, removing abbreviations, profanity, punctuation and extra spaces.  
  
The word/phrase entered by user is matched across 2, 3, 4, 5-grams generated using data from sources: news, twitter and blogs (Data Courtesy: *Switft Key*) to find the most frequent word ensuing the input.  
  
5-grams is given maximum priority so if a match is found there, the ensuing word is directly displayed followed by 4-gram, 3-gram and 2-gram.  
  
  
How to use:
========================================================
autosize: true
font-family: Cambria
transition: rotate

To provide you with the most suitable word, you are required to enter a word or a phrase in the text box provided in app and Click **Predict Next Word** button.    
  
The phrase entered will then be used to find the most frequently used combination of words resembling the input using the dataset provided by Swift Key. The model then displays the recommended word in the output text box.  
  
**Note:** Please note that the app may take some time to display the first prediction as data needs to be loaded on server before executing the search algorithm.    
  
  
Snapshot:
========================================================
autosize: true
font-family: Cambria
transition: rotate

![App Overview](https://cloud.githubusercontent.com/assets/15130682/16863012/625e838e-4a14-11e6-8103-d8387edd077c.jpg)
  
  
[Click Here](https://madhuri8933.shinyapps.io/Next_Word_Predictor/) to Begin App
