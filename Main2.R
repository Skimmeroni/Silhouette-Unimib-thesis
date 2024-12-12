library(ggplot2)

datasets <- list.files(path = "data", pattern = "^[a-r|t-z|0-9]")

#clustering_methods <- c("KMEANS", "HIERARCHICAL-CLUSTERING", "DBSCAN",
#                        "BIRCH", "MEAN-SHIFT", "HDBSCAN")

clustering_methods <- c("KMEANS")

for (method in clustering_methods) {
	file <- paste0("bin/Clustering_", method, ".R")
	source(file)

	filename <- paste0("results/results_c_", method, ".pdf")
	pdf(filename)

	for (d in datasets) {
		dataset <- read.csv(paste0("data/", d))
		dataset <- na.omit(dataset)
		K_vector <- retrieve_opt_clusters_number(dataset)

		opt_K <- which.max(K_vector) + 1
		dataframe <- create_clustering_dataframe(dataset, opt_K)

		sil_dataframe <- data.frame(var1 = 2:10, var2 = K_vector)
		colnames(sil_dataframe) = c("X", "Y")

		print(ggplot(data = sil_dataframe, mapping = aes(x = X, y = Y)) +
		      ylim(-1, 1) +
		      scale_x_continuous(limits = c(2, 10)) +
		      geom_line() +
		      geom_point() +
		      labs(title = paste0("Elbow plot: ", method),
		           subtitle = paste0("Dataset: ", d),
		           x = "Number of clusters",
		           y = "Average Silhouette width"))

		print(ggplot(data = dataframe, mapping = aes(Cluster)) +
		      geom_bar(aes(fill = Cluster)) +
		      theme(legend.position = "top") +
		      labs(title = paste0("Clustering: ", method),
		           subtitle = paste0("Dataset: ", d),
		           y = "Cluster size",
		           x = "Cluster number"))
	}

	dev.off()
}
