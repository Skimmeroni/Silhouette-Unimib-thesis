compute_avg_Silhouette <- function(matrix) {
	# Import the package
	library(Kira)

	# Apply k-means on the dataset, with 2 centroids
	clustering_result <- silhouette(matrix, k.cluster = 2,
	                                plot = FALSE, savptc = FALSE)

	# Extract the average Silhouette score
	sil_avg <- clustering_result$eve.si

	return(sil_avg)
}

create_plottable_df <- function(dataframe) {
	# Import the package
	library(Kira)

	# Apply k-means with 2 clusters
	kmeans_result <- kmeans(dataframe, num.groups = 2)

	plottable_dataframe <- kmeans_result$group
	colnames(plottable_dataframe) <- c("X", "Y", "Cluster")
	plottable_dataframe <- transform(plottable_dataframe,
	                                 Cluster = as.character(Cluster))

	return(plottable_dataframe)
}
