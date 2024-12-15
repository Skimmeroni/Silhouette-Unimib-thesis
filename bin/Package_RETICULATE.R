compute_avg_Silhouette <- function(matrix) {
	# Import the package
	library(reticulate)
	use_python("/usr/bin/python")
	skl_cluster <- import("sklearn.cluster")
	skl_metrics <- import("sklearn.metrics")

	dataset <- as.data.frame(matrix)

	kmeans <- skl_cluster$KMeans(n_clusters = as.integer(2),
	                             random_state = as.integer(0),
	                             n_init = "auto")

	sil_avg <- skl_metrics$silhouette_score(dataset,
	                                        kmeans$fit_predict(dataset))

	return(sil_avg)
}

create_plottable_df <- function(dataframe) {
	# Import the package
	library(reticulate)
	use_python("/usr/bin/python")
	skl_cluster <- import("sklearn.cluster")

	matrix <- as.matrix(dataframe)

	kmeans <- skl_cluster$KMeans(n_clusters = as.integer(2),
	                             random_state = as.integer(0),
	                             n_init = "auto")

	kmeans_result <- kmeans$fit(dataframe)

	# Extract the clustering result
	clusters <- kmeans_result$labels_
	clusters <- clusters + 1

	plottable_dataframe <- data.frame(var1 = matrix, var2 = clusters)
	colnames(plottable_dataframe) <- c("X", "Y", "Cluster")
	plottable_dataframe <- transform(plottable_dataframe,
	                                 Cluster = as.character(Cluster))
	return(plottable_dataframe)
}
