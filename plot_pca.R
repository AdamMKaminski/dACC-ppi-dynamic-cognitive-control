#
# PLOT PCA (plot_pca)
#
# Arguments: PCA object, title for plot, name for x-axis, names for variables along x-axis
#
plot_pca <- function(data.pca,title,x_lab,x_vars){
  
  if(!("reshape2" %in% (.packages()))){library(reshape2)}
  if(!("factoextra" %in% (.packages()))){library(factoextra)}
  
  x  <- c(1:length(x_vars))
  PC1 <- data.pca$rotation[,1]
  PC2 <- data.pca$rotation[,2]
  PC3 <- data.pca$rotation[,3]
  PC4 <- data.pca$rotation[,4]
  df <- data.frame(x, PC1, PC2, PC3, PC4)
  X_axis <- x_vars
  
  # melt the data to a long format
  df2 <- melt(data = df, id.vars = "x")
  
  # plot, using the aesthetics argument 'color'
  plot <- ggplot(data = df2, aes(x = x, y = value, color = variable)) + 
    geom_line() +
    ylab("Factor Loadings") +
    xlab(x_lab) +
    scale_x_continuous(breaks=1:length(x_vars), labels=X_axis) +
    guides(color=guide_legend(title="")) +
    ggtitle(title) +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5))
  return(plot)
}
