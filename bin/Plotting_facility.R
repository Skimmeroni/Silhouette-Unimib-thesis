plot_results <- function(sc_score_good, sc_score_bad, bms, package_name, time) {
	filename <- paste("results/results_", toupper(package_name), ".pdf",
	                  sep = "")
	file <- paste("bin/Package_", toupper(package_name), ".R", sep = "")
	source(file)

	sc_dataset_good <- create_plottable_df("data/sc_dataset_good.csv")
	sc_dataset_bad <- create_plottable_df("data/sc_dataset_bad.csv")

	library(ggplot2)
	library(gridExtra)

	sc_plot_good <- ggplot(data = sc_dataset_good,
	                       mapping = aes(x = X, y = Y, color = Cluster)) +
	                geom_point() +
	                labs(title = paste("Sanity check (good) for package: ",
	                     package_name, sep = ""),
	                     subtitle = paste("Average Silhouette score: ",
	                     sc_score_good, "\nCompleted in: ", time, " seconds",
	                     sep = ""),
	                     x = "X",
	                     y = "Y")

	sc_plot_bad <- ggplot(data = sc_dataset_bad,
	                       mapping = aes(x = X, y = Y, color = Cluster)) +
	               geom_point() +
	               labs(title = paste("Sanity check (bad) for package: ",
	                    package_name, sep = ""),
	                    subtitle = paste("Average Silhouette score: ",
	                    sc_score_bad, "\nCompleted in: ", time, " seconds",
	                    sep = ""),
	                    x = "X",
	                    y = "Y")

	plot_bms <- ggplot(data = bms, mapping = aes(x = X, y = Y)) +
	            geom_point() +
	            geom_smooth(method = "lm") +
	            labs(title = paste("Binary matrix for package: ", package_name,
	                 sep = ""),
	                 subtitle = paste("Completed in: ", time, " seconds",
	                 sep = ""),
	                 y = "Average Silhouette score \n for the i-th iteration",
	                 x = "Iteration")

	ggsave(filename, arrangeGrob(sc_plot_good, sc_plot_bad, plot_bms))
}
