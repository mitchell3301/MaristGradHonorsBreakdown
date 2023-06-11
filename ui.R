navbarPage('Marist College 2023 Graduation Honors',
           tabsetPanel(
             tabPanel('Introduction',
                      mainPanel(
                        br(),
                        strong(em(h2('Marist College Graduating Honors Analyzer'))),
                        h3(strong('!!! Mobile support not great. Flip phone horizontal for best experience as 
                                  vertical crops out some of the charts and metrics.')),
                        br(),
                        h4(em('Motivation')),
                        p('To build an application to allow for visualizations and
                                   analytics to examine the Class of 2023 and the honors
                                   that were graduated with'),
                        br(),
                        h4(em('Design Process')),
                        p('First step was to take pictures of the commencement program
                                   and then scan them in as images. Ran OCR (optical character recognition)
                                   on the document to allow for highlighting and copying. Once we placed the data
                                   into a spreadsheet and did some minor cleaning where the OCR gave inaccurate data,
                                   we uploaded the CSV into R and made it into a dataframe.'),
                        br(),
                        h4(em('Future Additions')),
                        p('Ability to examine by degree type (BA, BS, BFA, ...)'),
                        br(),
                        h4(em('GitHub')),
                        a('https://github.com/mitchell3301/MaristGradHonorsBreakdown',
                          href = 'https://github.com/mitchell3301/MaristGradHonorsBreakdown')
                      )),
             tabPanel(
               'Student Body',
               mainPanel(
                 br(),
                 plotlyOutput('overallBreakdown')
               )
             ),
             tabPanel(
               'Breakdowns by Academic School',
               mainPanel(
                 
                 br(),
                 fluidRow(
                  
                   
                  tags$div(
                    HTML(
                      '<h1>Graduation Honors by School</h1>
                      <br>
                      <div style="display: flex; align-items: center;">
                      <div style="width: 25px; height: 25px; background: #B76C9E;"></div>
                      <p style="font-size: 15px; padding: 0px 8px 0px 4px">None</p>
                      <div style="width: 25px; height: 25px; background: #4285F4;"></div>
                      <p style="font-size: 15px; padding:0px 8px 0px 4px;">Cum Laude</p>
                      <div style="width: 25px; height: 25px; background: #EA4335;"></div>
                      <p style="font-size: 15px; padding:0px 8px 0px 4px;">Magna Cum Laude</p>
                      <div style="width: 25px; height: 25px; background: #129842;"></div>
                      <p style="font-size: 15px; padding:0px 8px 0px 4px;">Summa Cum Laude</p>
                      </div>')
                  )
                 ),
                 br(),
                 fluidRow(
                   splitLayout(cellWidths = c("50%", "50%"), 
                               plotlyOutput("comm"),
                               plotlyOutput("management"))
                 ),
                 fluidRow(
                   splitLayout(cellWidths = c("50%", "50%"), 
                               plotlyOutput("social"), 
                               plotlyOutput("liberalArts"))
                 ),
                 fluidRow(
                   splitLayout(cellWidths = c("50%", "50%"), 
                               plotlyOutput("science"),
                               plotlyOutput("compSci"))
                 )
               )
           ))) # navbarPage



