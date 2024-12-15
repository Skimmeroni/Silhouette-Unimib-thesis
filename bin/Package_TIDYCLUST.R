compute_avg_Silhouette <- function(dataframe) {
	# Import the package
	library(tidyclust)

	# Coerce into a matrix
	matrix <- as.matrix(dataframe)

	# Apply k-means on the dataset with 2 centroids
	kmeans_spec <- k_means(num_clusters = 2, engine = "stats")
	kmeans_result <- fit(kmeans_spec, ~., dataframe)

	# Compute the Silhouette widths
	sil_widths <- silhouette_avg(kmeans_result, dists = dist(matrix))

	# Extract the average Silhouette score
	sil_avg <- sil_widths$.estimate

	return(sil_avg)
}

create_plottable_df <- function(dataframe) {
	# Import the package
	library(tidyclust)

	# Coerce into a matrix
	matrix <- as.matrix(dataframe)

	# Apply k-means on the dataset with 2 centroids
	kmeans_spec <- k_means(num_clusters = 2, engine = "stats")
	kmeans_result <- fit(kmeans_spec, ~., dataframe)

	# Extract the clustering result
	clusters <- as.vector((kmeans_result$fit)$cluster)

	# Create a dataframe with the clustering result
	plottable_dataframe <- data.frame(var1 = matrix, var2 = clusters)
	colnames(plottable_dataframe) <- c("X", "Y", "Cluster")
	plottable_dataframe <- transform(plottable_dataframe,
	                                 Cluster = as.character(Cluster))

	return(plottable_dataframe)
}
