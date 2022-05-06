# Shiny Application

shinyApp(
    
    # UI
    
    ui = fluidPage(
        
        #tags$head(
            #tags$link(rel = "stylesheet", type = "text/css", href = "participant_identification_tool.css")
        #), ## Created some custom CSS but havent included it in this example. 
        
        titlePanel(title = h3(strong("Participant Identification Tool"))),
        
        sidebarLayout(
            sidebarPanel(
                
                # Database Choice 
                selectInput(
                    inputId = "database_choice",
                    label = "Select Database:", 
                    width = "100%",
                    choices = c("data", "example_of_alt_data"),
                    selected = "data"
                    ),
                
                # Participant ID
                textInput(
                    inputId = "participant_id",
                    label = "Enter Participant ID:",
                    width = "100%"
                    ),
                
                # First Name
                textInput(
                    inputId = "firstname",
                    label = "Enter First Name:",
                    width = "100%"
                    ),
                
                # Middle Names
                textInput(
                    inputId = "middlenames",
                    label = "Enter Middle Name(s):",
                    width = "100%"
                ),
                
                # Surnames
                textInput(
                    inputId = "surname",
                    label = "Enter Surname(s):",
                    width = "100%"
                ),
                
                # Date of Birth
                textInput(
                    inputId = "dob", 
                    label = "Enter Date of Birth:",
                    placeholder = "DD-MM-YYYY", 
                    width = "100%"
                ),
                
                # Post Code
                textInput(
                    inputId = "postcode",
                    label = "Enter Postal Code:",
                    width = "100%"
                ),
                
                # Address
                textInput(
                    inputId = "address",
                    label = "Enter Full Address:",
                    width = "100%"
                )
                
            ),
            
            # Ouput
            mainPanel(
                
                textOutput("nparticipants"),
                br(),
                tableOutput("table_outcomes")
                
            )
        )
    ),
    
    
    # Server 
    server = function(input, output) {
        
        # Filtering Database based on Inputs
        tab <- reactive({ 
            
            tab <- get({input$database_choice})
            
            if(!is.na(input$participant_id))
                tab <- tab %>% filter(str_detect(study_id, gsub("[^0-9_]", "", input$participant_id)))

                if(!is.na(input$firstname))
                    tab <- tab %>% filter(str_detect(first_name, gsub("[^A-Za-z-]", "", tolower(input$firstname))))

                    if(!is.na(input$surname))
                        tab <- tab %>% filter(str_detect(last_name, gsub("[^A-Za-z-]", "", tolower(input$surname))))
                    
                        if(!is.na(input$middlenames))
                            tab <- tab %>% filter(str_detect(middle_name, gsub("[^A-Za-z-]", "", tolower(input$middlenames))))
                        
                            if(!is.na(input$dob))
                                tab <- tab %>% filter(str_detect(dob, gsub("[^0-9/]", "", input$dob)))
                                
                                if(!is.na(input$postcode))
                                    tab <- tab %>% filter(str_detect(post_code, gsub("[^A-Za-z0-9]", "", tolower(input$postcode))))
                            
                                    if(!is.na(input$address))
                                        tab <- tab %>% filter(str_detect(address, gsub("[^A-Za-z0-9, ]", "", tolower(input$address))))
                    
            return(tab)
                    
        })
        
        # Summary Data 
        output$nparticipants <- renderText({ paste("Total Number of Participants Matching Criteria:", nrow(tab())) })
    
        # Table Output 
        output$table_outcomes <- renderTable({ tab() }, bordered = T, spacing = "s", width = "100%", hover = T)
       
    }

)

