tune_hyperparameters <- function(dataset) {
	library(dbscan, warn.conflicts = FALSE)

	matrix <- as.matrix(dataset)

	H_dataframe <- data.frame(minPoints = numeric(),
	                          epsilon = numeric(),
	                          sil_avg = numeric())

	minPoints_range <- seq(ncol(dataset) + 1, ncol(dataset) * 2)

	for (minPoints in minPoints_range) {
		max_distance <- max(kNNdist(dataset, k = minPoints))
		epsilon_range <- seq(0, max_distance, by = max_distance / 10)

		for (epsilon in epsilon_range) {
			dbscan_result <- dbscan(dataset, eps = epsilon, minPts = minPoints)

			# Compute the Silhouette widths
			sil_result <- silhouette(dbscan_result$cluster, dist(matrix))

			if (!is.atomic(summary(sil_result))) {
				# Extract the average Silhouette score
				sil_avg <- summary(sil_result)$avg.width

				H_dataframe[nrow(H_dataframe) + 1, ] <- c(minPoints,
				                                          round(epsilon,
				                                                digits = 5),
				                                          sil_avg)
			}
		}
	}

	return(H_dataframe)
}

create_clustering_dataframe <- function(dataset, optimal_set) {
	opt_minPoints <- optimal_set$minPoints
	opt_epsilon <- optimal_set$epsilon

	dbscan_result <- dbscan(dataset, eps = opt_epsilon, minPts = opt_minPoints)

	clustering_df <- as.data.frame(dbscan_result$cluster)
	colnames(clustering_df) <- c("Cluster")
	clustering_df <- transform(clustering_df, Cluster = as.character(Cluster))

	return(clustering_df)
}

hyperparameter_plot <- function(H_frame, dataset) {
	H_frame <- transform(H_frame, minPoints = as.character(minPoints))

	P <- ggplot(data = H_frame,
		        mapping = aes(x = epsilon, y = sil_avg,
		                      color = minPoints, group = minPoints)) +
		 ylim(-1, 1) +
		 geom_line() +
		 geom_point() +
		 labs(title = paste0("Dataset: ", dataset),
		      subtitle = "DBSCAN elbow plot",
		      x = "Epsilon",
		      y = "Average Silhouette width")

	return(P)
}

customized_plot <- function(dataframe, dataset) {
	parameters <- read.csv("data/s_DBSCAN.csv")
	visual_opt_set <- as.vector(subset(parameters, filename == dataset))
	visual_opt_set <- c(visual_opt_set[2], visual_opt_set[3])

	visual_dataframe <- create_clustering_dataframe(dataframe, visual_opt_set)
	visual_string <- paste(names(visual_opt_set), visual_opt_set,
	                       sep = " = ", collapse = ", ")

	palette <- c("#3d85c6", "#6fa8dc", "#9fc5e8", "#c27ba0", "#a64d79")

	P <- ggplot(data = visual_dataframe, aes(Cluster, y = after_stat(count) /
		                                           sum(after_stat(count)))) +
		 scale_fill_manual(values = palette) +
		 geom_bar(aes(fill = Cluster)) +
		 theme(legend.position = "top") +
		 ylim(0, 1) +
		 labs(title = paste0("Dataset: ", dataset),
		      subtitle = paste0("DBSCAN clustering with visual inspection",
		                        "\nParameters used: ", visual_string),
		      y = "Cluster size (normalized to [0, 1])",
		      x = "Cluster number")

	return(P)
}
