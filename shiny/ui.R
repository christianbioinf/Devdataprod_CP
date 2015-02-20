library(shiny)
library(rCharts)

shinyUI(
    navbarPage("Benchmarking read aligners",
               tabPanel("Plot",
                        sidebarPanel(
                            selectInput("dataset", "Dataset:",
                                        list("Illumina (artificial)",
                                             #"Illumina (short artificial)",
                                             "Illumina (DNA-seq)",
                                             "Illumina (mRNA-seq)",
                                             #"Illumina (smallRNA-seq)",
                                             "Illumina (paired-end artificial)",
                                             "Illumina (paired-end DNA-seq)",
                                             "Illumina (paired-end mRNA-seq)",
                                             "454 (artificial)",
                                             "454 (DNA-seq)"
                                             )),                                             
                            radioButtons(
                                "measure",
                                "Type of measure to display:",
                                c("Sensitivity" = "sens",
                                  "False Positives" = "fp",
                                  "Running time" = "time",
                                  "Memory consumption" = "mem")
                            )
                        ),
                        mainPanel(
                            showOutput("plot", "highcharts")
                        )),
               tabPanel("Data",
                        mainPanel(dataTableOutput("table"),
                                  downloadButton('downloadData', 'Download data')
                                  )
                        ),                            
               tabPanel("About",
                        mainPanel(
                            includeMarkdown("include.md")
                        ))
               )
)
