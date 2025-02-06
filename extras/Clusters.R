# Load library containing Silhouette and plots
library(cluster)
library(ggplot2)

# Load dataset
SC <- read.csv("../data/sil_dataset.csv")

# Coerce into a matrix
M <- as.matrix(SC)

# Compute the matrix distance
D <- dist(SC)

for (k in c(2, 4, 6)) {
	# Compute K-Means
	clustering_result <- kmeans(M, centers = k)

	# Extract the clustering result
	C <- clustering_result$cluster

	# Create a dataframe with the clustering result
	PL <- data.frame(var1 = M, var2 = C)
	colnames(PL) <- c("X", "Y", "cluster")
	PL <- transform(PL, cluster = as.character(cluster))

	# Compute s(i) for all elements
	S <- silhouette(C, D)
	Avg <- summary(S)$avg.width

	# Plot clustering result
	pdf(paste0("../doc/clusters-", k, ".pdf"))
	P <- ggplot(data = PL, mapping = aes(x = X, y = Y, color = cluster)) +
	             geom_point() + labs(title = paste0("Average s(i): ", Avg), x = "X", y = "Y")
	print(P)
	dev.off()
}
