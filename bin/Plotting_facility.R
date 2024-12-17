sanity_check_plot <- function(dataset, dataframe, package_name, score, time) {
	P <- ggplot(data = dataframe, mapping = aes(x = X, y = Y,
	                                            color = Cluster)) +
	     scale_color_manual(values = c("blue", "green")) +
	     geom_point() +
	     labs(title = paste0("Sanity check for package: ", package_name),
	          subtitle = paste0("Using dataset: ", dataset,
	                            "\nAverage Silhouette score: ", score,
	                            "\nCompleted in: ", time, " seconds"),
	          x = "X", y = "Y")

	return(P)
}

binary_matrix_plot <- function(score_vector, package_name, time) {
	P <- ggplot(data = score_vector, mapping = aes(x = X, y = Y)) +
	     ylim(-1, 1) +
	     scale_color_manual(values = c("blue", "green")) +
	     geom_point() +
	     geom_smooth(formula = y ~ x, method = "lm") +
	     labs(title = paste0("Binary matrix for package: ", package_name),
	          subtitle = paste0("Completed in: ", time, " seconds"),
	          y = "Average Silhouette score for the i-th iteration",
	          x = "Iteration")

	return(P)
}

clustering_generic_plot <- function(dataframe, string, dataset, method) {
	P <- ggplot(data = dataframe, mapping = aes(Cluster)) +
		 geom_bar(aes(fill = Cluster)) +
		 theme(legend.position = "top") +
		 labs(title = paste0("Clustering: ", method),
		      subtitle = paste0("Dataset: ", dataset,
		                        "\nParameters used: ", string),
		      y = "Cluster size",
		      x = "Cluster number")

	return(P)
}
