plot_results <- function(sc_score_good, sc_score_bad, bms, package_name, time) {
	filename <- paste0("results/results_", toupper(package_name), ".pdf")
	file <- paste0("bin/Package_", toupper(package_name), ".R")
	source(file)

	library(ggplot2)

	sc_dataset_good <- create_plottable_df("data/sc_dataset_good.csv")
	sc_dataset_bad <- create_plottable_df("data/sc_dataset_bad.csv")

	pdf(filename)
	print(ggplot(data = sc_dataset_good,
	             mapping = aes(x = X, y = Y, color = Cluster)) +
	      scale_color_manual(values = c("blue", "green")) +
	      geom_point() +
	      labs(title = paste0("Sanity check (good) for package: ",
	           package_name),
	           subtitle = paste0("Average Silhouette score: ",
	                            sc_score_good, "\nCompleted in: ", time, "
	                            seconds"),
	           x = "X",
	           y = "Y"))
	print(ggplot(data = sc_dataset_bad,
	             mapping = aes(x = X, y = Y, color = Cluster)) +
	      scale_color_manual(values = c("blue", "green")) +
	      geom_point() +
	      labs(title = paste0("Sanity check (bad) for package: ",
	           package_name),
	           subtitle = paste0("Average Silhouette score: ",
	                            sc_score_bad, "\nCompleted in: ", time, "
	                            seconds"),
	           x = "X",
	           y = "Y"))
	print(ggplot(data = bms, mapping = aes(x = X, y = Y)) +
	      ylim(-1, 1) +
	      scale_color_manual(values = c("blue", "green")) +
	      geom_point() +
	      geom_smooth(formula = y ~ x, method = "lm") +
	      labs(title = paste0("Binary matrix for package: ", package_name),
	           subtitle = paste0("Completed in: ", time, " seconds"),
	           y = "Average Silhouette score for the i-th iteration",
	           x = "Iteration"))
	dev.off()
}

clustering_generic_plot <- function(dataframe, dataset, method) {
	P <- ggplot(data = dataframe, mapping = aes(Cluster)) +
		 geom_bar(aes(fill = Cluster)) +
		 theme(legend.position = "top") +
		 labs(title = paste0("Clustering: ", method),
		      subtitle = paste0("Dataset: ", dataset),
		      y = "Cluster size",
		      x = "Cluster number")

	return(P)
}
