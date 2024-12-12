retrieve_opt_clusters_number <- function(dataset) {
	library(cluster)

	matrix <- as.matrix(dataset)

	sil_avgs_vector <- c()

	for (i in 2:10) {
		# Apply k-means with an increasing number of clusters
		kmeans_result <- kmeans(matrix, centers = i)

		# Compute the Silhouette widths
		sil_result <- silhouette(kmeans_result$cluster, dist(matrix))

		# Extract the average Silhouette score
		sil_avg <- summary(sil_result)$avg.width

		sil_avgs_vector <- append(sil_avgs_vector, sil_avg)
	}

	return(sil_avgs_vector)
}

create_clustering_dataframe <- function(dataset, optimal_k) {
	matrix <- as.matrix(dataset)

	kmeans_result <- kmeans(matrix, centers = optimal_k)

	clustering_df <- as.data.frame(kmeans_result$cluster)
	colnames(clustering_df) <- c("Cluster")
	clustering_df <- transform(clustering_df, Cluster = as.character(Cluster))

	return(clustering_df)
}
