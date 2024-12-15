all_packages <- c("cluster", "drclust", "tidyclust", "Kira", "reticulate")

for (package in all_packages) {
	if (system.file(package = package) == "") {
		stop(c("Missing package: ", package))
	}
}

cat("All packages are installed. Proceeding... \n")

# Load ggplot2 here, so that computed time is consistent
library(ggplot2)
source("bin/Plotting_facility.R")
source("bin/Binary_matrix.R")

for (package in all_packages) {
	# Load functions needed for the current package
	cat("Current package:", package, "\n")
	file <- paste0("bin/Package_", toupper(package), ".R")
	source(file)

	# Load sanity check dataset (favorable case)
	start_time <- Sys.time()
	sc_filename_good <- "sc_dataset_good.csv"
	sc_dataset_good <- read.csv(paste0("data/", sc_filename_good))

	# Compute average Silhouette score and clustering
	sc_score_good <- round(compute_avg_Silhouette(sc_dataset_good), digits = 2)
	sc_dataframe_good <- create_plottable_df(sc_dataset_good)
	finish_time <- round(Sys.time() - start_time, digits = 2)

	# Plot the result
	sc_plot_good <- sanity_check_plot(sc_filename_good, sc_dataframe_good,
	                                  package, sc_score_good, finish_time)

	# Load sanity check dataset (unfavorable case)
	start_time <- Sys.time()
	sc_filename_bad <- "sc_dataset_bad.csv"
	sc_dataset_bad <- read.csv(paste0("data/", sc_filename_bad))

	# Compute average Silhouette score and clustering
	sc_score_bad <- round(compute_avg_Silhouette(sc_dataset_bad), digits = 2)
	sc_dataframe_bad <- create_plottable_df(sc_dataset_bad)
	finish_time <- round(Sys.time() - start_time, digits = 2)

	# Plot the result
	sc_plot_bad <- sanity_check_plot(sc_filename_bad, sc_dataframe_bad,
	                                 package, sc_score_bad, finish_time)

	# Compute the Silhouette scores for binary matrix
	start_time <- Sys.time()
	bm_scores <- avg_sil_scores_for_bm(20, 10, package)
	finish_time <- round(Sys.time() - start_time, digits = 2)

	# Plot the result
	bm_plot <- binary_matrix_plot(bm_scores, package, finish_time)

	result <- paste0("results/results_", toupper(package), ".pdf")
	pdf(result)
	print(sc_plot_good)
	print(sc_plot_bad)
	print(bm_plot)
	dev.off()
}

# ????????
for (i in list.files(pattern = "Rplots*")) {
	file.remove(i)
}
