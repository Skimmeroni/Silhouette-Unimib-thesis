data(iris)
iris <- iris[, -5]
iris <- head(iris)
distance_matrix <- as.matrix(dist(iris))
write.csv(distance_matrix, "../data/sdist.csv", row.names = FALSE)
