library(ggplot2)

datasets <- list.files(path = "data", pattern = "^[a-r|t-z|0-9]")

#clustering_methods <- c("KMEANS", "HIERARCHICAL-CLUSTERING", "DBSCAN",
#                        "BIRCH", "MEAN-SHIFT", "HDBSCAN")

clustering_methods <- c("KMEANS", "DBSCAN")

for (method in clustering_methods) {
	file <- paste0("bin/Clustering_", method, ".R")
	source(file)

	filename <- paste0("results/results_c_", method, ".pdf")
	pdf(filename)

	for (d in datasets) {
		dataset <- read.csv(paste0("data/", d))
		dataset <- na.omit(dataset)

		H_frame <- tune_hyperparameters(dataset)
		opt_num <- which.max(H_frame$sil_avg)
		opt_set <- H_frame[opt_num, ]
		opt_set <- subset(opt_set, select = -sil_avg)
		opt_set <- as.vector(opt_set)

		dataframe <- create_clustering_dataframe(dataset, opt_set)
		extra_plot <- customized_plot(H_frame, d)
		print(extra_plot)

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
