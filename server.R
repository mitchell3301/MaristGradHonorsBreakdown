library(dplyr)
library(plotly)

# Visualization Ideas ---------------------------------------------------------
# Overall
# By School
# By Degree Type
# Honors Program vs Non-Honors Program
shinyServer(function(input, output, session) {
  
  pal = c("#B76C9E", "#4285F4","#EA4335", "#129842")
  
  df <- as.data.frame(read.csv('srcData.csv')) %>%
    mutate(Honors = replace(Honors, Honors == 'ERROR', 'Summa Cum Laude'))
  # TEMP FIX FOR ERROR
  
  
  # Chart for breakdown of honors by entire student body
  overall <- plot_ly(
    df %>% group_by(Honors)
    %>% summarise(Count = n())
    %>% arrange(match(
      Honors,
      c("None", "Cum Laude", "Magna Cum Laude", "Summa Cum Laude") # custom sort
    )),
    labels = ~ Honors,
    values = ~ Count,
    marker=list(colors=pal)
  ) %>% config(displayModeBar = F) %>% layout(title = 'Breakdown of Student Body')%>% add_pie(hole = 0.6) 
  # If you remove the add_pie from that even to a new line it breaks...

  
  # Output plot to server
  output$overallBreakdown <- renderPlotly(overall)
  
  
  # Breakdowns by School ------------------------------------------------------
  
  #' createPlotForSchool
  #' Creates a plot_ly object of a doughnut chart for individual academic school
  #' @param school, the school on which plot is create
  #' @param df, original source data frame
  #' *** MUST BE
  createPlotForSchool <- function(desiredSchool, srcData) {
    
    # pal = c("#B76C9E", "#4285F4","#EA4335", "#129842")
    
   
    
    #legend = list(orientation = 'h')
    
    plot <- plot_ly(
      srcData %>% group_by(School, Honors)
      %>% filter(School == desiredSchool)
      %>% summarise(Count = n())
      %>% 
        arrange(School,
                match(
        Honors,
        c("None", "Cum Laude", "Magna Cum Laude", "Summa Cum Laude")
      )),
      labels = ~ Honors,
      values = ~ Count,
      marker=list(colors=pal),
      sort = FALSE
    ) %>% config(displayModeBar = F) %>% layout(title = desiredSchool, showlegend = F) %>% add_pie(hole = 0.6)
    
    


    return(plot)
    
  } # createPlotForSchool
  
  
  # Output to UI
  
  output$comm <- renderPlotly(createPlotForSchool('Communication and the Arts', df))
  output$management <- renderPlotly(createPlotForSchool('Management', df))
  output$liberalArts <- renderPlotly(createPlotForSchool('Liberal Arts', df))
  output$social <- renderPlotly(createPlotForSchool('Social and Behavioral Science', df))
  output$science <- renderPlotly(createPlotForSchool('Science', df))
  output$compSci <- renderPlotly(createPlotForSchool('Computer Science and Mathematics', df))
  
  
}) # shinyServer