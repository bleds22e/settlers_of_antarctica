# knn-plot for module 3
# Keaton Wilson
# keatonwilson@me.com
# 2020-03-10

#packages
library(MASS)
library(class)
library(tidyverse)

# function to make a plot when you put in model and data


knn_plot = function(data, model){
  
  # loading model
  classif = model
  
  prob = attr(classif, "prob")
  
  dataf <- bind_rows(mutate(collars_to_label,
                            prob=prob,
                            cls="Budget Collars LLC",
                            prob_cls=ifelse(classif==cls,
                                            1, 0)),
                     mutate(collars_to_label,
                            prob=prob,
                            cls="Collarium Inc.",
                            prob_cls=ifelse(classif==cls,
                                            1, 0)))
  print("Ready to plot")
  
  ggplot() +
    #geom_point(aes(x=x, y=y, col=cls, size=prob),
     #          data = mutate(test, cls=classif)) +
    #scale_size(range=c(0.8, 2)) +
    geom_contour(aes(x=x, y=y, z=prob_cls, group=cls, color=cls),
                 bins=2,
                 data=dataf) +
    geom_point(aes(x=x, y=y, col=cls),
               size=3,
               data=data.frame(x=train[,1], y=train[,2], cls=cl)) +
    geom_point(aes(x=x, y=y),
               size=3, shape=1,
               data=data.frame(x=train[,1], y=train[,2], cls=cl)) +
    xlab("Normalized Battery Life") +
    ylab("Normalized Signal Distance")
  
}


boundary <- function(model, data, class = NULL, predict_type = "class",
                     resolution = 100, showgrid = TRUE, ...) {
  
  if(!is.null(class)) cl <- data[,class] else cl <- 1
  data <- data[,2:3]
  k <- nrow(unique(cl))
  
  plot(data, col = cl$maker) #, pch = as.integer(cl)+1)
  
  d# make grid
  r <- sapply(data, range, na.rm = TRUE)
  xs <- seq(r[1,1], r[2,1], length.out = resolution)
  ys <- seq(r[1,2], r[2,2], length.out = resolution)
  g <- cbind(rep(xs, each=resolution), rep(ys, time = resolution))
  colnames(g) <- colnames(r)
  g <- as.data.frame(g)
  
  ### guess how to get class labels from predict
  ### (unfortunately not very consistent between models)
  p <- predict(model, g, type = predict_type)
  if(is.list(p)) p <- p$class
  p <- as.factor(p)
  
  if(showgrid) points(g, col = as.integer(p)+1L, pch = ".")
  
  z <- matrix(as.integer(p), nrow = resolution, byrow = TRUE)
  contour(xs, ys, z, add = TRUE, drawlabels = FALSE,
          lwd = 2, levels = (1:(k-1))+.5)
  
  invisible(z)
}


#Manual testing
# knn_data = knn_data
# mod_test = knn(train, test, cl, k = 7, prob=TRUE)
# 
# 
# knn_plot(data = knn_data, model = mod_test)
