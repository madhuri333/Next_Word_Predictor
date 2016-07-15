#=======================================================================================================
# Predict Next Word : Capstone Project (ui.R forApp)
# Purpose: Help user type quickly by predicting next word corresponding to input word/ phrase.
#=======================================================================================================


library(shiny)
library(markdown)

# Define server logic required to run the app and display viable option to user
# Remove preceding and trailing spaces
remove_traling <- function(x) {
  x <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", x)
  return(x)
}

# Find number of words in phrase
word_count <- function(sentence) {
  num_words <- sum(sapply(strsplit(sentence, split = " "), length))
  return(num_words)
}

# Remove punctuations, extra spaces, abbreviations, convert to lower case, remove profanity to get text in the format of n-grams
cleaned <- function(txt){
  
  # Replace "t's" with "t is", "n't" with " not", "i'm" with "i am", "'ll" with " will", "'re" with " are", "'d" with " would" and "'ve" with " have"
  txt <- gsub(txt, pattern = "n't", replacement = " not")
  txt <- gsub(txt, pattern = "[Ii]'m", replacement = "i am")
  txt <- gsub(txt, pattern = "t's", replacement="t is")
  txt <- gsub(txt, pattern = "'ve | ve ", replacement=" have ")
  txt <- gsub(txt, pattern = "'re", replacement = " are")
  txt <- gsub(txt, pattern = "'d", replacement = " would")
  txt <- gsub(txt, pattern = "'ll", replacement=" will")
  
  # Keep only alphabetical part
  txt <- gsub(txt, pattern = "[^[:alpha:]]", replacement = " ")
  
  # Remove extra "s" left from words like Tom's, stroller's etc
  txt <- gsub(pattern="\\s+[s]\\s+", replacement = " " , x = txt)
  
  # Convert to lower case
  txt <- tolower(txt)
  
  suppressWarnings(profane <- read.csv("swearWords.csv"))
  profane <- tolower(colnames(profane))
  
  # Remove Profanity
  remove_profanity <- function(x) {
    gsub(x, pattern = paste(profane, collapse = "|"), replacement = "")
  }
  
  txt <- remove_profanity(txt)
  
  rm(profane)
  
  # Remove extra single letters except "i" and "a" from start, end or middle of sentences
  txt <- gsub(txt, pattern="^[b-h|j-z]$|\\s+[b-h|j-z]\\s+|\\s+[b-h|j-z]$", replacement = " ")
  
  # Remove extra spaces
  txt <- gsub(txt, pattern="\\s+", replacement=" ")
  
  # Remove trailing spaces
  txt <- remove_traling(txt)
  
  return(txt)
}


# Load ngram data set
two_gram <- read.csv('two_gram.csv', header=TRUE)
three_gram <- read.csv('three_gram.csv', header=TRUE)
four_gram <- read.csv('four_gram.csv', header=TRUE)
five_gram <- read.csv('five_gram.csv', header=TRUE)


# Finding nearest 2-gram
find_match2 <- function(txt) {
  found <- grepl(two_gram$Term, pattern = txt)
  found <- two_gram[found, ]
  found <- found[order(found$Freq, decreasing = TRUE), ]
  return(as.character(found$Term[1]))
}

# Finding nearest 3-gram
find_match3 <- function(txt) {
  found <- grepl(three_gram$Term, pattern = txt)
  found <- three_gram[found, ]
  found <- found[order(found$Freq, decreasing = TRUE), ]
  return(as.character(found$Term[1]))
}

# Finding nearest 4-gram
find_match4 <- function(txt) {
  found <- grepl(four_gram$Term, pattern = txt)
  found <- four_gram[found, ]
  found <- found[order(found$Freq, decreasing = TRUE), ]
  return(as.character(found$Term[1]))
}

# Finding nearest 5-gram
find_match5 <- function(txt) {
  found <- grepl(five_gram$Term, pattern = txt)
  found <- five_gram[found, ]
  found <- found[order(found$Freq, decreasing = TRUE), ]
  return(as.character(found$Term[1]))
}

len_four <- function(phrase){
  # Separate all words in phrase
  words <- strsplit(phrase, split = " ")
  words <- words[[1]]
  
  # Add trailing space at end to avoid phrase being the last word in n-gram
  phrase <- paste0("^",phrase, " ")
  
  # Find most frequently used next word from 2,3,4,5-grams for the phrase
  # First priority is for 5-gram then 4 then 3 then 2
  match <- find_match5(phrase)
  if(is.na(match)){
    phrase <- paste(words[(length(words)-2) : length(words)], collapse = " ")
    phrase <- paste0("^",phrase," ")
    match <- find_match4(phrase)
    if(is.na(match)){
      phrase <- paste(words[(length(words)-1) : length(words)], collapse = " ")
      phrase <- paste0("^",phrase," ")
      match <- find_match3(phrase)
      if(is.na(match)){
        phrase <- paste(words[length(words)])
        phrase <- paste0("^",phrase," ")
        match <- find_match2(phrase)
        if(is.na(match)){
          return("")
        }
        else
        {
          predicted_word <- strsplit(match, phrase)[[1]][2]
          return(predicted_word)
        }
      }
      else{
        predicted_word <- strsplit(match, phrase)[[1]][2]
        return(predicted_word)
      }
    }
    else{
      predicted_word <- strsplit(match, phrase)[[1]][2]
      return(predicted_word)
    }
  }
  else{
    predicted_word <- strsplit(match, phrase)[[1]][2]
    return(predicted_word)
  }
  
}

len_three <- function(phrase){
  # Separate all words in phrase
  words <- strsplit(phrase, split = " ")
  words <- words[[1]]
  
  # Add trailing space at end to avoid phrase being the last word in n-gram
  phrase <- paste0("^",phrase, " ")
  
  # Find most frequently used next word from 2,3,4-grams for the phrase
  # First priority is for 4-gram then 3 then 2
  match <- find_match4(phrase)
  if(is.na(match)){
      phrase <- paste(words[(length(words)-1) : length(words)], collapse = " ")
      phrase <- paste0("^",phrase," ")
      match <- find_match3(phrase)
      if(is.na(match)){
        phrase <- paste(words[length(words)])
        phrase <- paste0("^",phrase," ")
        match <- find_match2(phrase)
        if(is.na(match)){
          return("")
        }
        else
        {
          predicted_word <- strsplit(match, phrase)[[1]][2]
          return(predicted_word)
        }
      }
      else{
        predicted_word <- strsplit(match, phrase)[[1]][2]
        return(predicted_word)
      }
    }
    else{
      predicted_word <- strsplit(match, phrase)[[1]][2]
      return(predicted_word)
    }
}


len_two <- function(phrase){
  # Separate all words in phrase
  words <- strsplit(phrase, split = " ")
  words <- words[[1]]
  
  # Add trailing space at end to avoid phrase being the last word in n-gram
  phrase <- paste0("^",phrase, " ")
  
  # Find most frequently used next word from 2,3-grams for the phrase
  # First priority is for 3-gram then 2
  match <- find_match3(phrase)
    if(is.na(match)){
      phrase <- paste(words[length(words)])
      phrase <- paste0("^",phrase," ")
      match <- find_match2(phrase)
      if(is.na(match)){
        return("")
      }
      else
      {
        predicted_word <- strsplit(match, phrase)[[1]][2]
        return(predicted_word)
      }
    }
    else{
      predicted_word <- strsplit(match, phrase)[[1]][2]
      return(predicted_word)
    }
}
  

get_next_word <- function(phrase) { 
  
  # If null or spaces, return null
  if(nchar(remove_traling(phrase)) == 0)
    return ("")
  
  length_phrase <- word_count(remove_traling(phrase))
  
  # If words in phrase > 4 then take last 4 words as input as max that can be used in 5-gram is 4 words
  if(length_phrase > 4){
    words <- strsplit(remove_traling(phrase), split = " ")
    words <- words[[1]]
    phrase <- paste(words[(length(words)-3) : length(words)], collapse = " ")
  }
  
  phrase <- cleaned(phrase)
  
  if(word_count(phrase)==4){
    return(len_four(phrase))
  }
  
  if(word_count(phrase)==3){
    return(len_three(phrase))
  }
  
  if(word_count(phrase)==2){
    return(len_two(phrase))
  }
  
  if(word_count(phrase)==1){
    phrase <- paste0("^",phrase," ")
    match <- find_match2(phrase)
    if(is.na(match)){
      return("")
    }
    else{
      predicted_word <- strsplit(match, phrase)[[1]][2]
      return(predicted_word)
    }
  }
  
}


# Define server logic  
shinyServer(function(input, output) {
  number <- 0
  output$prediction <- renderPrint({ 
    #if(input$act > number){
      get_next_word(input$phrase)
     # number = input$act
    #}
  })
  
})

