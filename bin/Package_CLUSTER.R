compute_avg_Silhouette <- function(dataframe) {
	# Import the package
	library(cluster)

	# Coerce into a matrix
	matrix <- as.matrix(dataframe)

	# Apply k-means on the matrix with 2 centroids
	kmeans_result <- kmeans(matrix, centers = 2)

	# Compute the Silhouette widths
	sil_widths <- silhouette(kmeans_result$cluster, dist(matrix))

	# Extract the average Silhouette score
	sil_avg <- summary(sil_widths)$avg.width

	return(sil_avg)
}

create_plottable_df <- function(dataframe) {
	# Import the package
	library(cluster)

	# Coerce into a matrix
	matrix <- as.matrix(dataframe)

	# Apply k-means on the matrix with 2 centroids
	kmeans_result <- kmeans(matrix, centers = 2)

	# Extract the clustering result
	clusters <- kmeans_result$cluster

	# Create a dataframe with the clustering result
	plottable_dataframe <- data.frame(var1 = matrix, var2 = clusters)
	colnames(plottable_dataframe) <- c("X", "Y", "Cluster")
	plottable_dataframe <- transform(plottable_dataframe,
	                                 Cluster = as.character(Cluster))

	return(plottable_dataframe)
}
