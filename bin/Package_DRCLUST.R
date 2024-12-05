compute_si_Silhouette <- function(sanity_check_dataset) {
	# Import the package
	library(drclust)

	# Coerce dataframe into a matrix
	sc_matrix <- as.matrix(sanity_check_dataset)

	# Apply k-means on the dataset, with 2 centroids
	sc_clustering <- dpcakm(sc_matrix, 2, 1)

	# Compute the Silhouette
	sil_result <- silhouette(sc_matrix, sc_clustering)

	sil_result <- sil_result$cl.silhouette

	# Extract the widths
	sil_widths <- sil_result[, 3]

	return(sil_widths)
}

compute_avg_Silhouette <- function(binary_matrix) {
	# Import the package
	library(drclust)

	# Apply k-means on the dataset, with 2 centroids
	clustering <- dpcakm(binary_matrix, 2, 1)

	# Compute the Silhouette
	sil_result <- silhouette(binary_matrix, clustering)

	sil_result <- sil_result$cl.silhouette

	# Extract the widths
	sil_widths <- sil_result[, 3]

	# Compute the average Silhouette score
	sil_avg <- mean(sil_widths)

	return(sil_avg)
}
