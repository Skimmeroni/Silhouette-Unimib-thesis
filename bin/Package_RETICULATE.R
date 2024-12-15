compute_avg_Silhouette <- function(dataframe) {
	# Import the package
	library(reticulate)
	use_python("/usr/bin/python")
	skl_c <- import("sklearn.cluster")
	skl_m <- import("sklearn.metrics")

	# Fit k-means with 2 centroids
	kmeans_spec <- skl_c$KMeans(n_clusters = as.integer(2),
	                              random_state = as.integer(0),
	                              n_init = "auto")

	# Compute the average Silhouette score
	sil_avg <- skl_m$silhouette_score(dataframe,
	                                  kmeans_spec$fit_predict(dataframe))

	return(sil_avg)
}

create_plottable_df <- function(dataframe) {
	# Import the package
	library(reticulate)
	use_python("/usr/bin/python")
	skl_cluster <- import("sklearn.cluster")

	# Coerce into a matrix
	matrix <- as.matrix(dataframe)

	# Fit k-means with 2 centroids
	kmeans_spec <- skl_cluster$KMeans(n_clusters = as.integer(2),
	                                  random_state = as.integer(0),
	                                  n_init = "auto")

	# Apply k-means on the dataset with 2 centroids
	kmeans_result <- kmeans_spec$fit(dataframe)

	# Extract the clustering result
	clusters <- kmeans_result$labels_
	clusters <- clusters + 1

	# Create a dataframe with the clustering result
	plottable_dataframe <- data.frame(var1 = matrix, var2 = clusters)
	colnames(plottable_dataframe) <- c("X", "Y", "Cluster")
	plottable_dataframe <- transform(plottable_dataframe,
	                                 Cluster = as.character(Cluster))

	return(plottable_dataframe)
}
