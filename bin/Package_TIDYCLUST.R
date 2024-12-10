compute_avg_Silhouette <- function(matrix) {
	# Import the package
	library(tidyclust)

	# Coerce matrix into a dataframe
	dataset <- as.data.frame(matrix)

	# Apply k-means on the dataset, with 2 centroids
	kmeans_spec <- k_means(num_clusters = 2, engine = "stats")
	kmeans_fit <- fit(kmeans_spec, ~., dataset)

	# Compute the average Silhouette score
	sil_avg <- silhouette_avg(kmeans_fit, dists = dist(matrix))

	sil_avg <- sil_avg[, 3]$.estimate

	return(sil_avg)
}

create_plottable_df <- function(dataset_path) {
	# Import the package
	library(tidyclust)

	dataframe <- read.csv(dataset_path)

	matrix <- as.matrix(dataframe)

	# Apply k-means on the dataset, with 2 centroids
	kmeans_spec <- k_means(num_clusters = 2, engine = "stats")
	clustering_result <- fit(kmeans_spec, ~., dataframe)

	clusters <- as.vector((clustering_result$fit)$cluster)

	plottable_dataframe <- data.frame(var1 = matrix, var2 = clusters)
	colnames(plottable_dataframe) = c("X", "Y", "Cluster")
	plottable_dataframe <- transform(plottable_dataframe,
	                                 Cluster = as.character(Cluster))

	return(plottable_dataframe)
}
