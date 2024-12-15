library(ggplot2)

# Properly load datasets (exclude the custom ones)
dataset_filenames <- list.files(path = "data", pattern = "^[a-r|t-z|0-9]")

#clustering_methods <- c("KMEANS", "HIERARCHICAL-CLUSTERING", "DBSCAN",
#                        "BIRCH", "MEAN-SHIFT", "HDBSCAN")

clustering_methods <- c("KMEANS", "DBSCAN")

source("bin/Plotting_facility.R")

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
		optimal_dataframe <- create_clustering_dataframe(dataset, optimal_set)

		# Plot specific to the clustering algorithm (elbow plot, ecc...)
		custom_plot <- customized_plot(hyp_combinations, filename)
		print(custom_plot)

		# Generic plot with cluster size (same for all algorithms)
		generic_plot <- clustering_generic_plot(optimal_dataframe,
		                                        filename,
		                                        method)
		print(generic_plot)
	}

	dev.off()
}
