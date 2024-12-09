compute_avg_Silhouette <- function(matrix) {
	# Import the package
	library(drclust)

	# Apply k-means on the dataset, with 2 centroids
	clustering <- dpcakm(matrix, 2, 1)

	# Compute the Silhouette
	sil_result <- silhouette(matrix, clustering)

	sil_result <- sil_result$cl.silhouette

	# Extract the widths
	sil_widths <- sil_result[, 3]

	# Compute the average Silhouette score
	sil_avg <- mean(sil_widths)

	return(sil_avg)
}
