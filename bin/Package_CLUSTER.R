compute_avg_Silhouette <- function(matrix) {
	# Import the package
	library(cluster)

	# Apply k-means with 2 clusters
	kmeans_result <- kmeans(matrix, centers = 2)

	# Extract the clustering result
	clustering <- kmeans_result$cluster

	# Compute the Silhouette widths
	sil_result <- silhouette(clustering, dist(matrix))

	# Extract the widths
	sil_widths <- sil_result[, 3]

	# Compute the average Silhouette score
	sil_avg <- mean(sil_widths)

	return(sil_avg)
}
