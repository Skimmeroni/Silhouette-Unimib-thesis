tune_hyperparameters <- function(dataset) {
	library(cluster)
	library(Kmedians)

	matrix <- as.matrix(dataset)

	sil_avgs_vector <- c()

	for (i in 2:10) {
		# Apply k-medians with an increasing number of clusters
		kmedians_result <- Kmedians(matrix, nclust = seq(i, i))

		# Compute the Silhouette widths
		sil_result <- silhouette(kmedians_result$allresults$cluster, dist(matrix))

		# Extract the average Silhouette score
		sil_avg <- summary(sil_result)$avg.width

		sil_avgs_vector <- append(sil_avgs_vector, sil_avg)
	}

	H_dataframe <- data.frame(k = 2:10, sil_avg = sil_avgs_vector)
	return(H_dataframe)
}

create_clustering_dataframe <- function(dataset, optimal_set) {	
	optimal_k <- optimal_set$k
	matrix <- as.matrix(dataset)

	kmedians_result <- Kmedians(matrix, nclust = seq(optimal_k, optimal_k))

	clustering_df <- as.data.frame(kmedians_result$allresults$cluster)
	colnames(clustering_df) <- c("Cluster")
	clustering_df <- transform(clustering_df, Cluster = as.character(Cluster))

	return(clustering_df)
}

hyperparameter_plot <- function(H_frame, dataset) {
	P <- ggplot(data = H_frame, mapping = aes(x = k, y = sil_avg)) +
		      ylim(-1, 1) +
		      scale_x_continuous(limits = c(2, 10)) +
		      geom_line() +
		      geom_point() +
		      labs(title = paste0("Dataset: ", dataset),
		           subtitle = "K-Medians elbow plot",
		           x = "Number of clusters",
		           y = "Average Silhouette width")

	return(P)
}

customized_plot <- function(dataframe, dataset) {
	# No-op
	return(NULL)
}
