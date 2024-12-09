compute_avg_Silhouette <- function(matrix) {
	# Import the package
	library(tidyclust)

	# Coerce matrix into a dataframe
	dataset <- as.data.frame(matrix)

	# Apply k-means on the dataset, with 2 centroids
	kmeans_spec <- k_means(num_clusters = 2, engine = "stats")
	kmeans_fit <- fit(kmeans_spec, ~., dataset)

	# Compute the average Silhouette score
	sil_avg <- silhouette_avg(kmeans_fit, dists = dist(matrix))

	sil_avg <- sil_avg[, 3]$.estimate

	return(sil_avg)
}
