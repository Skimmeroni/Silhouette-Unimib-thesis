compute_avg_Silhouette <- function(dataframe) {
	# Import the package
	library(drclust, warn.conflicts = FALSE)

	# Coerce into a matrix
	matrix <- as.matrix(dataframe)

	# Apply k-means on the matrix with 2 centroids
	kmeans_result <- dpcakm(matrix, 2, 1)

	# Compute the Silhouette widths
	sil_widths <- silhouette(matrix, kmeans_result)

	# Extract the average Silhouette score
	sil_avg <- summary(sil_widths$cl.silhouette)$avg.width

	return(sil_avg)
}

create_plottable_df <- function(dataframe) {
	# Import the package
	library(drclust, warn.conflicts = FALSE)

	# Coerce into a matrix
	matrix <- as.matrix(dataframe)

	# Apply k-means on the matrix with 2 centroids
	clustering_result <- dpcakm(matrix, 2, 1)

	# Extract the clustering result
	clusters <- clustering_result$U + 1
	clusters <- clusters[, 1]

	# Create a dataframe with the clustering result
	plottable_dataframe <- data.frame(var1 = matrix, var2 = clusters)
	colnames(plottable_dataframe) <- c("X", "Y", "Cluster")
	plottable_dataframe <- transform(plottable_dataframe,
	                                 Cluster = as.character(Cluster))

	return(plottable_dataframe)
}
