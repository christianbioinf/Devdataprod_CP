library(shiny)

library(ggplot2)
library(rCharts)
library(plyr)
library(markdown)

myPreprocessData <- function(data){
    
    ## filter out BBMap
    data <- subset(data, tool != "BBMap")

    ## scale sens to %
    data$sens <- 100*data$sens

    ## scale mem to from kB to GB
    data$mem <- data$mem/(1024*1024)

    ## relabeling
    data$type <- revalue(data$type, c("allbest"="all-best", "anybest"="any-best"))
    data$tool <- revalue(data$tool, c("bowtie2" = "Bowtie 2", "bwa" = "BWA/BWA-SW",
                                      "bwasw" = "BWA/BWA-SW", "bwamem" = "BWA-MEM", "gem" = "GEM",
                                      "segemehl" = "segemehl", "star" = "STAR"))
    data$dataset <- revalue(data$dataset, c("artificial_illumina"="Illumina (artificial)",
                            "artificial_illumina_short"="Illumina (short artificial)",
                            "real_illumina_DNAseq"="Illumina (DNA-seq)",                                    
                            "real_illumina_mRNAseq"="Illumina (mRNA-seq)",
                            "real_illumina_shortRNAseq"="Illumina (smallRNA-seq)",
                            "artificial_illumina_paired"="Illumina (paired-end artificial)",
                            "real_illumina_DNAseq_paired"="Illumina (paired-end DNA-seq)",
                            "real_illumina_mRNAseq_paired"="Illumina (paired-end mRNA-seq)",
                            "artificial_454"="454 (artificial)",
                            "real_454_DNAseq"="454 (DNA-seq)"))

    return(data)
}

myPlot <- function(input, data){

    data <- subset(data, dataset == input$dataset)

    if (input$measure %in% c("sens", "fp")){
        h <- hPlot("tool", input$measure, data=data, color="tool", group="type", type="column")
    }
    else {
        data <- subset(data, type == "any-best")
        h <- hPlot("tool", input$measure, data=data, color="tool", type="column")
    }
    
    ylab <- switch(input$measure,
           sens = "Sensitvity",
           fp = "Number of false positives",
           mem = "Memory consumption [GB]",
                   time = "Running time [s]")
    h$xAxis(title = list(text = ""), categories = unique(data$tool))
    h$yAxis(title = list(text = ylab))
    h$tooltip(useHTML = T, formatter = "#! function() { return this.x + ': ' + this.y; } !#")
    h$addParams(dom = 'plot')
    return(h)
}

data <- read.table("data/all.eval.txt", header=TRUE)
data <- myPreprocessData(data)

shinyServer(
    function(input, output) {
        output$plot <- renderChart({
            return(myPlot(input, data))
        })

        output$debug <- renderText({
            paste("Dataset:", input$dataset, "\n",
                  "Measure:", input$measure, "\n")
        })
        
        output$table <- renderDataTable({
            data
        }, options = list(orderClasses = TRUE, bFilter = FALSE,
               lengthMenu = list(c(10, 50, -1), c('10', '50', 'All')),
               pageLength = 10, searching = TRUE))

        datasetInput <- reactive({data})
        
        output$downloadData <- downloadHandler(
            filename = 'data.csv',
            content = function(file) {
                write.csv(data, file)
            }
        )
    }
)

