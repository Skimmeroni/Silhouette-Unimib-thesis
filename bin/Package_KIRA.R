compute_avg_Silhouette <- function(dataframe) {
	# Import the package
	library(Kira)

	# Coerce into a matrix
	matrix <- as.matrix(dataframe)

	# Apply k-means on the matrix with 2 centroids
	kmeans_result <- silhouette(matrix, k.cluster = 2,
	                            plot = FALSE, savptc = FALSE)

	# Extract the average Silhouette score
	sil_avg <- kmeans_result$eve.si

	return(sil_avg)
}

create_plottable_df <- function(dataframe) {
	# Import the package
	library(Kira)

	# Apply k-means on the dataframe with 2 centroids
	kmeans_result <- kmeans(dataframe, num.groups = 2)

	# Extract the clustering result
	clusters <- kmeans_result$group

	# Create a dataframe with the clustering result
	plottable_dataframe <- clusters
	colnames(plottable_dataframe) <- c("X", "Y", "Cluster")
	plottable_dataframe <- transform(plottable_dataframe,
	                                 Cluster = as.character(Cluster))

	return(plottable_dataframe)
}
