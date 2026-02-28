library(shiny)
library(tm)
library(stringr)

# --- PREDICTION LOGIC SECTION (Simple) ---
# In the actual project, you should load your pre-processed N-gram database.
# This is a sample function for prediction simulation.
predict_next_word <- function(input_text) {
  if (input_text == "") return("")
  
  # Cleaning the input
  input_clean <- tolower(input_text)
  input_clean <- removePunctuation(input_clean)
  words <- unlist(strsplit(input_clean, " "))
  last_word <- tail(words, 1)
  
  # Dummy logic: Replace this with a lookup in your N-gram tables
  predictions <- list(
    "how" = "are",
    "thank" = "you",
    "new" = "york",
    "good" = "morning",
    "i" = "love"
  )
  
  result <- predictions[[last_word]]
  if (is.null(result)) return("the") # Default if no match is found
  return(result)
}

# --- USER INTERFACE (UI) ---
ui <- fluidPage(
  titlePanel("Next Word Predictor - Data Science Capstone"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("userInput", "Enter a phrase or word:", value = ""),
      hr(),
      helpText("This application predicts the next word in real-time based on your input.")
    ),
    
    mainPanel(
      h3("Predicted Next Word:"),
      verbatimTextOutput("prediction"),
      br(),
      h4("You entered:"),
      textOutput("enteredText")
    )
  )
)

# --- SERVER LOGIC ---
server <- function(input, output) {
  
  output$enteredText <- renderText({ input$userInput })
  
  output$prediction <- renderPrint({
    pred <- predict_next_word(input$userInput)
    cat(pred)
  })
}

# Run the application
shinyApp(ui = ui, server = server)
