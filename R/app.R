library(shiny)
library(ggplot2)
library(specmine.datasets)
library(uwot)

data(cachexia)

umap_analysis_dataset = function(dataset, n_components = 2, n_neighbors = 15, min_dist = 0.1,
                                 metric = "euclidean", scale = FALSE, seed = 42, ...) {
  mat_check = as.matrix(dataset$data)
  if (any(is.na(mat_check)) || any(is.nan(mat_check)) || any(is.infinite(mat_check))) {
    stop("dataset$data contains NA, NaN or Inf values. Please clean your data first.")
  }
  
  mat = t(mat_check)
  if (scale) mat = base::scale(mat)
  
  set.seed(seed)
  embedding = uwot::umap(
    mat,
    n_components = n_components,
    n_neighbors = n_neighbors,
    min_dist = min_dist,
    metric = metric,
    ...
  )
  
  rownames(embedding) = colnames(dataset$data)
  colnames(embedding) = paste0("UMAP", seq_len(n_components))
  
  list(
    embedding = embedding,
    params = list(
      n_components = n_components,
      n_neighbors = n_neighbors,
      min_dist = min_dist,
      metric = metric,
      scale = scale,
      seed = seed
    )
  )
}

ui <- fluidPage(
  titlePanel("Mini WebSpecmine - UMAP"),
  
  sidebarLayout(
    sidebarPanel(
      h4("UMAP parameters"),
      
      numericInput("n_components", "Number of components:", value = 2, min = 2, max = 3),
      numericInput("n_neighbors", "Number of neighbors:", value = 15, min = 2, max = 50),
      numericInput("min_dist", "Min distance:", value = 0.1, min = 0.0, max = 1.0, step = 0.05),
      
      selectInput("metric", "Distance metric:",
                  choices = c("euclidean", "cosine", "manhattan"),
                  selected = "euclidean"),
      
      checkboxInput("scale", "Scale data", value = TRUE),
      numericInput("seed", "Seed:", value = 42, min = 1),
      
      actionButton("run_umap", "Run UMAP")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("umapPlot", height = "500px")),
        tabPanel("Embedding Table", tableOutput("embeddingTable"))
      )
    )
  )
)

server <- function(input, output, session) {
  
  umap_result <- eventReactive(input$run_umap, {
    umap_analysis_dataset(
      dataset = cachexia,
      n_components = input$n_components,
      n_neighbors = input$n_neighbors,
      min_dist = input$min_dist,
      metric = input$metric,
      scale = input$scale,
      seed = input$seed
    )
  })
  
  output$umapPlot <- renderPlot({
    res = umap_result()
    emb = as.data.frame(res$embedding)
    
    if ("Muscle.loss" %in% colnames(cachexia$metadata)) {
      group_col = "Muscle.loss"
    } else if ("muscle.loss" %in% colnames(cachexia$metadata)) {
      group_col = "muscle.loss"
    } else {
      group_col = colnames(cachexia$metadata)[1]
    }
    
    emb$Group = as.factor(cachexia$metadata[, group_col])
    emb$Sample = rownames(emb)
    
    ggplot(emb, aes(x = UMAP1, y = UMAP2, colour = Group)) +
      geom_point(size = 3, alpha = 0.9) +
      theme_bw() +
      labs(
        title = "UMAP projection",
        x = "UMAP1",
        y = "UMAP2",
        colour = "Group"
      )
  })
  
  output$embeddingTable <- renderTable({
    res = umap_result()
    head(as.data.frame(res$embedding), 20)
  }, rownames = TRUE)
}

shinyApp(ui = ui, server = server)