compute_si_Silhouette <- function(sanity_check_dataset) {
	# Import the package
	library(cluster)

	# Apply k-means on the dataset, with 2 centroids
	sc_kmeans_result <- kmeans(sanity_check_dataset, centers = 2)

	# Extract the clustering result
	sc_clustering <- sc_kmeans_result$cluster

	# Compute the Silhouette widths
	sil_result <- silhouette(sc_clustering, dist(sanity_check_dataset))

	# Extract the widths
	sil_widths <- sil_result[, 3]

	return(sil_widths)
}

compute_avg_Silhouette <- function(binary_matrix) {
	# Import the package
	library(cluster)

	# Apply k-means with 2 clusters
	kmeans_result <- kmeans(binary_matrix, centers = 2)

	# Extract the clustering result
	clustering <- kmeans_result$cluster

	# Compute the Silhouette widths
	sil_result <- silhouette(clustering, dist(binary_matrix))

	# Extract the widths
	sil_widths <- sil_result[, 3]

	# Compute the average Silhouette score
	sil_avg <- mean(sil_widths)

	return(sil_avg)
}
