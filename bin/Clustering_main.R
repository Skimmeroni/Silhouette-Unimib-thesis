main <- function(clustering_methods, dataset_filenames) {
	for (method in clustering_methods) {
		cat("Current clustering algorithm:", method, "\n")

		# Load the functions specific for the clustering algorithm in use
		file <- paste0("bin/Clustering_", method, ".R")
		source(file)

		result <- paste0("results/results_c_", method, ".pdf")
		pdf(result)

		for (filename in dataset_filenames) {
			# Load the dataset and test some combinations of hyperparameters
			dataset <- read.csv(paste0("data/", filename))
			dataset <- na.omit(dataset)
			hyp_combinations <- tune_hyperparameters(dataset)

			# Extract the hyperparameter combination that maximizes Silhouette
			optimal_by_num <- which.max(hyp_combinations$sil_avg)
			optimal_set <- hyp_combinations[optimal_by_num, ]
			optimal_set <- subset(optimal_set, select = -sil_avg)
			optimal_set <- as.vector(optimal_set)

			# Apply clustering with such hyperparameter combination
			optimal_dataframe <- create_clustering_dataframe(dataset,
			                                                 optimal_set)

			# Plot regarding hyperparameters
			hyp_plot <- hyperparameter_plot(hyp_combinations, filename)
			print(hyp_plot)

			# Generic plot with cluster size (same for all algorithms)
			optimal_tostring <- paste(names(optimal_set), optimal_set,
									sep = " = ", collapse = ", ")
			generic_plot <- clustering_generic_plot(optimal_dataframe,
													optimal_tostring,
													filename,
													method)
			print(generic_plot)

			# Alternative plot, not using Silhouette (different for each
			# algorithm). May or may not exist
			custom_plot <- customized_plot(dataset, filename)
			if (!is.null(custom_plot)) {
				print(custom_plot)
			}

		}

		dev.off()
	}
}

clustering_generic_plot <- function(dataframe, string, dataset, method) {
	P <- ggplot(data = dataframe, aes(Cluster, y = after_stat(count) /
		                                           sum(after_stat(count)))) +
		 geom_bar(aes(fill = Cluster)) +
		 theme(legend.position = "top") +
		 ylim(0, 1) +
		 labs(title = paste0("Clustering: ", method),
		      subtitle = paste0("Dataset: ", dataset,
		                        "\nParameters used: ", string),
		      y = "Cluster size (in percentage)",
		      x = "Cluster number")

	return(P)
}
