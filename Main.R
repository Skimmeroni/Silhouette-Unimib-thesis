all_packages <- c("cluster", "drclust", "tidyclust", "Kira", "reticulate")

for (package in all_packages) {
	if (system.file(package = package) == "") {
		stop(c("Missing package: ", package))
	}
}

cat("All packages are installed. Proceeding... \n")

library(ggplot2)
source("bin/Plotting_facility.R")
source("bin/Binary_matrix.R")
source("bin/Sanity_check.R")

for (package in all_packages) {
	cat("Current package:", package, "\n")
	file <- paste0("bin/Package_", toupper(package), ".R")
	source(file)

	s_time <- Sys.time()
	sc_filename_good <- "sc_dataset_good.csv"
	sc_dataset_good <- read.csv(paste0("data/", sc_filename_good))
	sc_score_good <- avg_sil_score_for_sc(package, sc_dataset_good)
	sc_dataframe_good <- create_plottable_df(sc_dataset_good)
	f_time <- round(Sys.time() - s_time, digits = 2)
	sc_plot_good <- sanity_check_plot(sc_filename_good, sc_dataframe_good,
	                                  package, sc_score_good, f_time)

	s_time <- Sys.time()
	sc_filename_bad <- "sc_dataset_bad.csv"
	sc_dataset_bad <- read.csv(paste0("data/", sc_filename_bad))
	sc_score_bad <- avg_sil_score_for_sc(package, sc_dataset_bad)
	sc_dataframe_bad <- create_plottable_df(sc_dataset_bad)
	f_time <- round(Sys.time() - s_time, digits = 2)
	sc_plot_bad <- sanity_check_plot(sc_filename_bad, sc_dataframe_bad,
	                                  package, sc_score_bad, f_time)

	s_time <- Sys.time()
	bm_scores <- avg_sil_scores_for_bm(20, 10, package)
	f_time <- round(Sys.time() - s_time, digits = 2)
	bm_plot <- binary_matrix_plot(bm_scores, package, f_time)

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
