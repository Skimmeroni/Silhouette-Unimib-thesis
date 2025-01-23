tune_hyperparameters <- function(dataset) {
	library(dbscan, warn.conflicts = FALSE)

	matrix <- as.matrix(dataset)

	H_dataframe <- data.frame(minPoints = numeric(), sil_avg = numeric())

	minPoints_range <- seq(2, ncol(dataset) * 2)

	for (minPoints in minPoints_range) {
		hdbscan_result <- hdbscan(dataset, minPts = minPoints)

		# Compute the Silhouette widths
		sil_result <- silhouette(hdbscan_result$cluster, dist(matrix))

		if (!is.atomic(summary(sil_result))) {
			# Extract the average Silhouette score
			sil_avg <- summary(sil_result)$avg.width

			H_dataframe[nrow(H_dataframe) + 1, ] <- c(minPoints, sil_avg)
		}
	}

	return(H_dataframe)
}

create_clustering_dataframe <- function(dataset, optimal_set) {
	opt_minPoints <- optimal_set$minPoints

	dbscan_result <- hdbscan(dataset, minPts = opt_minPoints)

	clustering_df <- as.data.frame(dbscan_result$cluster)
	colnames(clustering_df) <- c("Cluster")
	clustering_df <- transform(clustering_df, Cluster = as.character(Cluster))

	return(clustering_df)
}

hyperparameter_plot <- function(H_frame, dataset) {
	P <- ggplot(data = H_frame, mapping = aes(x = minPoints, y = sil_avg)) +
		 ylim(-1, 1) +
		 geom_line() +
		 geom_point() +
		 labs(title = paste0("Dataset: ", dataset),
		      subtitle = "HDBSCAN elbow plot",
		      x = "MinPts",
		      y = "Average Silhouette width")

	return(P)
}

customized_plot <- function(dataframe, dataset) {
	# No-op
	return(NULL)
}
