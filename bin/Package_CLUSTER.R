compute_avg_Silhouette <- function(clustering_result, distance_matrix) {
	# Import the package
	library(cluster)

	#Compute the Silhouette widths
	sil_widths <- silhouette(clustering_result$cluster, dist(distance_matrix))

	# Compute the average Silhouette score
	sil_score <- mean(sil_widths[, 3])

	return(sil_score)
}

compute_si_Silhouette <- function(clustering_result, distance_matrix) {
	# Import the package
	library(cluster)

	#Compute the Silhouette widths
	sil_widths <- silhouette(clustering_result$cluster, dist(distance_matrix))

	return(sil_widths[, 3])
}
