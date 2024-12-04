compute_si_Silhouette <- function(clustering_result, distance_matrix) {
	# Import the package
	library(cluster)

	# Compute the Silhouette widths
	sil_result <- silhouette(clustering_result, dist(distance_matrix))

	# Extract the widths
	sil_widths <- sil_result[, 3]

	return(sil_widths)
}

compute_avg_Silhouette <- function(clustering_result, distance_matrix) {
	# Import the package
	library(cluster)

	# Compute the Silhouette widths
	sil_result <- silhouette(clustering_result, dist(distance_matrix))

	# Extract the widths
	sil_widths <- sil_result[, 3]

	# Compute the average Silhouette score
	sil_avg <- mean(sil_widths)

	return(sil_avg)
}
