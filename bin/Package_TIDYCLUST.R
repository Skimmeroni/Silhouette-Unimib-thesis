compute_si_Silhouette <- function(sanity_check_dataset) {
	# Import the package
	library(tidyclust)

	# Coerce dataframe into a matrix
	sc_matrix <- as.matrix(sanity_check_dataset)

	# Apply k-means on the dataset, with 2 centroids
	kmeans_spec <- k_means(num_clusters = 2, engine = "stats")
	kmeans_fit <- fit(kmeans_spec, ~., sanity_check_dataset)

	# Compute the Silhouette
	sil_result <- silhouette(kmeans_fit, dists = dist(sc_matrix))

	# Extract the widths
	sil_widths <- sil_result[, 3]$sil_width

	return(sil_widths)
}

compute_avg_Silhouette <- function(binary_matrix) {
	# Import the package
	library(tidyclust)

	# Coerce matrix into a datagrame
	binary_dataset <- as.data.frame(binary_matrix)

	# Apply k-means on the dataset, with 2 centroids
	kmeans_spec <- k_means(num_clusters = 2, engine = "stats")
	kmeans_fit <- fit(kmeans_spec, ~., binary_dataset)

	# Compute the average Silhouette score
	sil_avg <- silhouette_avg(kmeans_fit, dists = dist(binary_matrix))

	sil_avg <- sil_avg[, 3]$.estimate

	return(sil_avg)
}
